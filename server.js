/**
 * server.js – Express REST API for the Kraaktoernooi application.
 *
 * Endpoints:
 *   GET    /ping                     – health check
 *   GET    /toernooien               – list all tournaments
 *   GET    /toernooien/:id           – get a single tournament
 *   POST   /toernooien               – create a tournament
 *   PUT    /toernooien/:id           – update a tournament
 *   DELETE /toernooien/:id           – delete a tournament + its PDF
 *   GET    /tournamentID?datum=      – find tournament by date
 *   GET    /spelers                  – list all players
 *   POST   /spelers                  – add a player
 *   GET    /ranking                  – full player ranking with scores
 *   GET    /savedTeams               – list saved team pairs
 *   POST   /standardTeams            – sync standard teams from client
 *   POST   /cleanTeamsAndPlayers     – remove orphaned teams/players
 *   POST   /pdfs                     – upload a PDF
 *   GET    /pdfs/:filename/exists    – check if a PDF exists
 *   GET    /pdfs/:filename           – serve a PDF file
 *   POST   /results                  – save match results
 *   GET    /results?toernooiID=      – get match results for a tournament
 */

import express from "express";
import pool from "./db.js"; // Import the database pool

import cors from 'cors';
import { corsOptions } from './corsConfig.js';

import multer from 'multer';
import fs from 'fs/promises';
import { constants, existsSync } from 'fs';

import path from 'path';
import { getBaseUploadPath, getPdfDiskPath, getTmpDiskPath, getPdfPublicUrl } from "./config/uploads.js";


// Multer setup for PDF uploads with 10 MB limit
const upload = multer({
  dest: getTmpDiskPath(''),
  limits: {
    fileSize: 10 * 1024 * 1024 // 10 MB
  }
});



const app = express();
app.use(cors(corsOptions()));

app.use(express.json());

// Serve uploaded PDFs as static files
const PDF_BASE_PATH = path.join(process.env.UPLOAD_BASE_PATH, process.env.UPLOAD_PDF_PATH);

app.use('/pdfs', express.static(PDF_BASE_PATH));

// let db = pool;

// Parse a value as JSON if it's a string, otherwise return it (or [])
const parseIfNeeded = (value) => {
  if (typeof value === "string") {
    try {
      return JSON.parse(value);
    } catch (e) {
      console.warn("Kon JSON niet parsen:", value);
      return [];
    }
  }
  return value || [];
};

// Remove temporary upload files older than 1 hour
async function cleanupTmpFolder() {

  const now = Date.now();
  const oneHour = 60 * 60 * 1000;
  const tmpDir = getTmpDiskPath('');

  try {
    const files = await fs.readdir(tmpDir);
    for (const file of files) {
      const filePath = path.join(tmpDir, file);
      try {
        const stats = await fs.stat(filePath);
        if (now - stats.mtimeMs > oneHour) {
          await fs.unlink(filePath);
        }
      } catch {
        // ignore individual file errors
      }
    }
  } catch (err) {
    console.error('Kan tmp/ niet lezen:', err);
  }
}


const start = async () => {

  app.get('/ping', (req, res) => {
    res.status(200).json({ status: 'ok' });
    // console.log('Ping ontvangen, server is actief');
  });


  // --- Tournament CRUD ---

  app.put("/toernooien/:id", async (req, res) => {
    const { id } = req.params;
    const { teams, matches, groups, groupMatches, finalMatches, groepsToernooi, repeatRounds, pdfUrl } = req.body;
    // console.log('Update toernooi ontvangen:', req.body);
    try {
      const sqlStr = 'UPDATE kraaktoernooien SET teams = ?, matches = ?, groups = ?, groupMatches = ?, finalMatches = ?, groepsToernooi = ?, repeatRounds = ?, pdfUrl = ? WHERE id = ?';
      await pool.execute(sqlStr, [
        JSON.stringify(parseIfNeeded(teams)),
        JSON.stringify(parseIfNeeded(matches)),
        JSON.stringify(parseIfNeeded(groups)),
        JSON.stringify(parseIfNeeded(groupMatches)),
        JSON.stringify(parseIfNeeded(finalMatches)),
        groepsToernooi ?? false,
        repeatRounds ?? 1,
        pdfUrl ?? null,
        id
      ]);
      res.sendStatus(204);
    } catch (error) {
      console.error("Fout bij updaten toernooi:", error);
      return res.status(500).json({ error: "Interne serverfout" });
    }
  });

  // --- PDF management ---

  // POST /pdfs
  app.post('/pdfs', upload.single('file'), async (req, res) => {
    if (!req.file) {
      return res.status(400).json({ error: 'No file uploaded' });
    }

    if (req.file.mimetype !== 'application/pdf') {
      await fs.unlink(req.file.path).catch(() => {});
      return res.status(400).json({ error: 'Only PDF files are allowed' });
    }

    const filename = req.file.originalname
      .replace(/\s+/g, '-')
      .toLowerCase();

    const targetPath = getPdfDiskPath(filename);

    await fs.copyFile(req.file.path, targetPath);
    await fs.unlink(req.file.path);

    const publicUrl = getPdfPublicUrl(filename);

    res.json({ url: publicUrl, filename , success: true});
  });

  // GET /pdfs/:filename/exists
  app.get('/pdfs/:filename/exists', async (req, res) => {
    const filename = path.basename(req.params.filename)
      .replace(/\s+/g, '-')
      .toLowerCase();

    const filepath = getPdfDiskPath(filename);

    try {
      await fs.access(filepath, constants.F_OK);
      return res.json({ exists: true });
    } catch {
      return res.json({ exists: false });
    }
  });

  app.get('/pdfs/:filename', async (req, res) => {
    const filename = path.basename(req.params.filename);
    const filepath = getPdfDiskPath(filename);
    console.log("Filename and filepath:", filename, filepath);
    try {
      await fs.access(filepath, constants.F_OK);
      res.sendFile(filepath);
    } catch {
      res.status(404).json({ error: 'PDF not found' });
    }
  });


  app.post("/toernooien", async (req, res) => {
    // console.log('Nieuwe toernooi ontvangen:', req.body);
    const { datum, teams, matches, groups, groupMatches, finalMatches, groepsToernooi, repeatRounds, pdfUrl } = req.body;
    // console.log('Nieuwe toernooi data:', { datum, teams, matches, groups, groupMatches, finalMatches, groepsToernooi, repeatRounds, pdfUrl });
    const [existing] = await pool.execute('SELECT * FROM kraaktoernooien WHERE datum = ?', [datum]);
    if (existing.length > 0) {
      return res.status(409).json({ error: "Toernooi met deze datum bestaat al" });
    }
    let sqlStr = "INSERT INTO kraaktoernooien (datum, teams, groups, matches, groupMatches, finalMatches, groepsToernooi, repeatRounds, pdfUrl) ";
    sqlStr += "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";

    try {
      const [result] = await pool.execute(sqlStr, [
        datum ?? null,
        JSON.stringify(parseIfNeeded(teams)),
        JSON.stringify(parseIfNeeded(groups)),
        JSON.stringify(parseIfNeeded(matches)),
        JSON.stringify(parseIfNeeded(groupMatches)),
        JSON.stringify(parseIfNeeded(finalMatches)),
        groepsToernooi ?? false,
        repeatRounds ?? 1,
        pdfUrl ?? null
      ]);
      res.status(201).json({
        message: "Toernooi succesvol aangemaakt",
        id: result.insertId
      });
    } catch (error) {
      console.error("Fout bij aanmaken toernooi:", error);
      res.status(500).json({ error: "Interne serverfout" });
    }
  });

  app.get("/toernooien", async (req, res) => {
    try {
    const [rows] = await pool.execute(
      "SELECT * FROM kraaktoernooien ORDER BY datum DESC"
    );
    res.json(rows);
  } catch (error) {
    console.error("Fout bij ophalen toernooien:", error);
    res.status(500).json({ error: "Interne serverfout" });
  }
  });

  app.get("/toernooien/:id", async (req, res) => {
    try {
    const { id } = req.params;
    const [rows] = await pool.execute(
      "SELECT * FROM kraaktoernooien WHERE id = ?",
      [id]
    );
    if (rows.length === 0) {
      return res.status(404).json({ error: "Toernooi niet gevonden" });
    }
    res.json(rows[0]);
  } catch (error) {
    console.error("Fout bij ophalen toernooi:", error);
    res.status(500).json({ error: "Interne serverfout" });
  }
  });

  app.get("/tournamentID", async (req, res) => {
    const { datum } = req.query;
    if (!datum) {
      return res.status(400).json({ error: "Datum is verplicht" });
    }
    try {
      const [rows] = await pool.execute(
        "SELECT * FROM kraaktoernooien WHERE datum = ?", [datum]
      );
      if (rows.length === 0) {
        return res.status(204).json({ error: "Geen toernooi gevonden voor deze datum" });
      }
      //      // console.log("Toernooi gevonden:", rows[0]);
      res.json(rows[0]);
    } catch (error) {
      console.error("Fout bij ophalen toernooi:", error);
      res.status(500).json({ error: "Interne serverfout" });
    }
  });

  app.delete("/toernooien/:id", async (req, res) => {
    const { id } = req.params;
    try {
    const [rows] = await pool.execute(
      "SELECT pdfUrl FROM kraaktoernooien WHERE id = ?",
      [id]
    );
    if (rows.length === 0) {
      return res.status(404).json({ error: "Toernooi niet gevonden" });
    }
    const filename = rows[0].pdfUrl;
    if (filename) {
      const filepath = getPdfDiskPath(filename);
      if (existsSync(filepath)) {
        await fs.unlink(filepath);
      } else {
        console.warn(`PDF niet gevonden: ${filepath}`);
      }
    }
    const [result] = await pool.execute(
      "DELETE FROM kraaktoernooien WHERE id = ?",
      [id]
    );
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: "Toernooi niet gevonden" });
    }

    res.sendStatus(204);
    } catch (error) {
      console.error("Fout bij verwijderen toernooi:", error);
      res.status(500).json({ error: "Interne serverfout" });
    }
  });

  app.post("/spelers", async (req, res) => {
    try {
    const { naam } = req.body;
    const [rows] = await pool.execute(
      "SELECT * FROM spelers WHERE naam = ?", [naam]
    );
    if (rows.length === 0) {
      await pool.execute("INSERT INTO spelers (naam) VALUES (?)", [naam]);
    }
    res.sendStatus(201);
    } catch (error) {
      console.error("Fout bij toevoegen speler:", error);
      res.status(500).json({ error: "Interne serverfout" });
    }
  });

  app.get("/spelers", async (req, res) => {
    try {
    const [rows] = await pool.execute("SELECT * FROM spelers ORDER BY naam ASC");
    res.json(rows);
    } catch (error) {
      console.error("Fout bij ophalen spelers:", error);
      res.status(500).json({ error: "Interne serverfout" });
    }
  });

  app.post("/cleanTeamsAndPlayers", async (req, res) => {
    try {
    const teamsVerwijderd = await cleanKraakTeams();
    const spelersVerwijderd = await cleanSpelersTable();

    //    // console.log(`Opgeruimd: ${teamsVerwijderd.length} teams en ${spelersVerwijderd.length} spelers.`);
    //    // console.log("Teams verwijderd:", teams);
    //    // console.log("Spelers verwijderd:", spelers);
    const aantal = teamsVerwijderd.length + spelersVerwijderd.length;
    res.json({ success: true, aantal: aantal, items: { teams: teamsVerwijderd, spelers: spelersVerwijderd } });
    } catch (error) {
      console.error("Fout bij opschonen teams en spelers:", error);
      res.status(500).json({ error: "Interne serverfout" });
    }
  });

  // Calculate team score totals from match rounds (for regular tournaments)
  function calculateTeamScores(matches, teams) {
    // console.log("Bereken team scores voor teams:");
    const teamScores = teams.map((team, index) => ({ team, punten: 0 }));
    // console.log("Team scores voor teams:", teamScores);
    matches.forEach((round, index) => {
      round.forEach((tafel) => {
        // console.log(`Ronde ${index + 1}: ${JSON.stringify(tafel)}`);
        const teamLIndex = teams.indexOf(tafel.teamL);
        const teamRIndex = teams.indexOf(tafel.teamR);
        //        // console.log(`Team L index: ${teamLIndex}, Team R index: ${teamRIndex}`);
        if (teamLIndex === -1 || teamRIndex === -1) {
          // console.warn(`Team niet gevonden: ${index}: ${tafel.teamL} of ${tafel.teamR}`);
          return;
        }
        teamScores[teamLIndex].punten += tafel.scoreL;
        teamScores[teamRIndex].punten += tafel.scoreR;
        //        // console.log(`Team L (${teamScores[teamLIndex].team}) score: ${tafel.scoreL}, Team R (${teamScores[teamRIndex].team}) score: ${tafel.scoreR}`);
      });
    });

    // Sorteer op punten aflopend, en wijs een ranking toe
    teamScores.sort((a, b) => b.punten - a.punten);
    teamScores.forEach((team, i) => {
      team.rank = i + 1;
    });

    return teamScores;
  }
  // --- Ranking calculation ---
  //
  // Points scheme: 1st = 12, 2nd = 9, 3rd = 6, 4th = 3, participation = 1.
  // Each player's total = sum of their best 6 tournament scores.

  // TODO: Points depending on number of teams. 
  // 8 teams: 1st = 16, 2nd = 13, 3rd = 8, 4th = 3, 5-8 = 1
  // 7 teams: 1st = 14, 2nd = 11, 3rd = 6, 4th = 2, 5-7 = 1
  // 6 teams: 1st = 12, 2nd = 9, 3rd = 4, 4-6 = 1
  // 5 teams: 1st = 10, 2nd = 6, 3-5 = 1
  // 4 teams: 1st = 8, 2nd = 4, 3rd = 1, 4th = 1

  const getSpelersLijst = async () => {
    // remove spelers die niet in een team zitten
    const [rows] = await pool.execute("SELECT * FROM spelers ORDER BY naam ASC");
    return rows;
  };
  // Added endpoint for ranking players
  app.get("/ranking", async (req, res) => {
    const allSpelers = await getSpelersLijst();
    const [toernooien] = await pool.execute("SELECT datum, teams, matches, finalMatches, groepstoernooi FROM kraaktoernooien");
    //    // console.log("Toernooien:", toernooien);
    const puntenSchema = [12, 9, 6, 3];
    const spelerScores = {}
    toernooien.forEach((toernooi) => {
      // eerst alles op nul punten zetten
      allSpelers.forEach(player => {
        if (!spelerScores[player.naam]) {
          spelerScores[player.naam] = { totaal: 0, scores: [] };
        }
        spelerScores[player.naam].scores.push({ datum: toernooi.datum, punten: 0 });
        // console.log(`Speler ${player.naam} toegevoegd aan spelerScores`, spelerScores[player.naam].scores[spelerScores[player.naam].scores.length - 1].datum);
      });
      // console.log("Speler scores initialized for toernooi:", toernooi.datum, spelerScores);
      // console.log("Toernooi:", toernooi.datum);
      const teams = JSON.parse(toernooi.teams || "[]");
      const matches = JSON.parse(toernooi.matches || "[]");
      const finalMatches = JSON.parse(toernooi.finalMatches || "[]");
      // console.log("Teams:", teams);
      // console.log("Matches:", matches);
      // console.log("Final matches:", finalMatches);
      const groepstoernooi = toernooi.groepstoernooi || false;
      const deelnamePunt = 1; // Elk team krijgt 1 punt voor deelname
      let ranglijst = [];
      // Verwerk de teams
      // groepstoernooi
      if (groepstoernooi) {
        const [finale, derdePlek] = finalMatches
        const winnaar = finale.scoreR > finale.scoreL ? finale.teamR : finale.teamL;
        const tweede = winnaar === finale.teamR ? finale.teamL : finale.teamR;
        const derde = derdePlek.scoreR > derdePlek.scoreL ? derdePlek.teamR : derdePlek.teamL;
        const vierde = derde === derdePlek.teamR ? derdePlek.teamL : derdePlek.teamR;

        ranglijst = [winnaar, tweede, derde, vierde];
        // console.log("Ranglijst voor groepstoernooi:", ranglijst);

      } else {
        // reguliere toernooi
        const teamScores = calculateTeamScores(JSON.parse(toernooi.matches || "[]"), teams);
        // console.log("Team scores:", teamScores);
        // Wijs de teams toe aan de ranglijst
        for (let i = 0; i < 4; i++) {
          if (i >= teamScores.length) break; // Stop als er minder dan 4 teams zijn
          const team = teamScores[i].team;
          ranglijst.push(team);
        }
      }
      // voeg de overige teams toe aan de ranglijst 
      const geplaatsteTeams = new Set(ranglijst);
      teams.forEach((team, index) => {
        // voor het geval de teamspelers in een andere volgorde staan
        const tmSpelers = team.split("/");
        const team2 = `${tmSpelers[1]}/${tmSpelers[0]}`;
        // console.log(`Controleer team: ${team} of ${team2}`);
        if (!geplaatsteTeams.has(team) && !geplaatsteTeams.has(team2)) ranglijst.push(team);
      });
      // console.log("Ranglijst:",toernooi.datum, ranglijst);
      ranglijst.forEach((team, positie) => {
        if (!team) return;
        const punten = positie < 4 ? puntenSchema[positie] : deelnamePunt
        const spelers = team.split("/");
        spelers.forEach((speler, index) => {
        // if(speler.trim() !== ""){
        //   console.log(`index: ${index}, Toernooi ${toernooi.datum}, team: ${team}, speler: ${speler}, positie: ${positie + 1}, punten: ${punten}`);
        // }

          updateScore(spelerScores, speler, punten, toernooi.datum);
          updateTotaal(spelerScores, speler);
        });
      })

    })
    //    // console.log("Speler scores:", spelerScores);
    const ranking = Object.entries(spelerScores).map(([speler, { totaal, scores }]) => {
      //      // console.log(`Speler: ${speler}, Resultaten:`, scores);
      return { speler, totaal, scores };
    });

    ranking.sort((a, b) => b.totaal - a.totaal);
    updateRanking(ranking);
    //    // console.log("Ranglijst:", ranking);
    res.json(ranking);

  });

  // Update a player's score for a specific tournament date
  function updateScore(spelerScores, spelerNaam, punten, datum) {
    // console.log(`Update score voor ${spelerNaam} op ${datum}: +${punten} punten`);  
    const scores = spelerScores[spelerNaam].scores;
    const score = scores.find(s => s.datum === datum);
    if (score) {
      score.punten = punten;
    }

  }

  // Recalculate a player's total from their best 6 scores
  function updateTotaal(spelerScores, spelerNaam) {
    const totaal = berekenTotaal(spelerScores, spelerNaam);
    spelerScores[spelerNaam].totaal = totaal;
  }

  // Sort players by total and assign rank positions (shared ranks for ties)
  function updateRanking(spelers) {
    spelers.sort((a, b) => b.totaal - a.totaal);
    let vorigTotaal = null;
    let plaats = 0
    let offset = 1
    spelers.forEach((speler, index) => {
      if (speler.totaal !== vorigTotaal) {
        plaats = index + offset; // Plaats is 1-indexed
        vorigTotaal = speler.totaal;
      }
      speler.plaats = plaats;
    }
    );
    return spelers;

  }

  // Sum a player's best 6 tournament scores
  function berekenTotaal(spelerScores, spelerNaam) {
    const scores = spelerScores[spelerNaam].scores;
    const best6 = scores
      .map(s => s.punten)
      .sort((a, b) => b - a) // sorteer op punten aflopend
      .filter(punten => punten > 0) // filter negatieve punten eruit
      .slice(0, 6); // neem de beste 6 scores

    return best6.reduce((totaal, punten) => totaal + punten, 0);
  }

  // --- Player & team management helpers ---

  async function getOrCreatePlayer(naam) {
    const [rows] = await pool.execute(
      'SELECT id FROM spelers WHERE naam = ?',
      [naam]
    );
    if (rows.length > 0) return rows[0].id;

    const [result] = await pool.execute(
      'INSERT INTO spelers (naam) VALUES (?)',
      [naam]
    );
    return result.insertId;
  }

  // Remove players that are not part of any team
  async function cleanSpelersTable() {
    // Verwijder spelers die niet in een team zitten
    const deletedSpelers = await pool.execute(`
      SELECT * from spelers WHERE id NOT IN (
        SELECT speler1 FROM kraakTeams
        UNION
        SELECT speler2 FROM kraakTeams
      ) 
    `);
    //    // console.log("Spelers zonder team:", deletedSpelers[0]);
    if (deletedSpelers[0].length === 0) return [];
    // verwijder deze spelers
    await pool.execute(`
      DELETE FROM spelers 
      WHERE id NOT IN (
        SELECT speler1 FROM kraakTeams
        UNION
        SELECT speler2 FROM kraakTeams
      )
    `);
    return deletedSpelers[0].map(speler => speler.naam);
    //    // console.log("Spelers zonder team verwijderd");
  }

  // verwijder teams die geen enkel toernooi hebben gespeeld
  async function cleanKraakTeams() {
    // vul een array met de namen van teamSpelers
    const sqlStr = `SELECT CONCAT(sp1.naam, '/', sp2.naam) AS team 
                    FROM laurierboom.kraakTeams kt
                    INNER JOIN spelers sp1 ON kt.speler1 = sp1.id
                    INNER JOIN spelers sp2 ON kt.speler2 = sp2.id
                    ORDER BY team`;

    const [rows] = await pool.execute(sqlStr);
    if (rows.length === 0) return 0;
    const teams = rows.map(row => row.team);
    //    // console.log("Teams in kraakTeams:", teams);
    const matchTeams = await pool.execute(`
      SELECT teams FROM kraaktoernooien
    `);
    const tnTeams = matchTeams[0].map(row => row.teams);
    //    // console.log("Teams in toernooien (geflatteerd):", tnTeams);
    if (tnTeams.length === 0) return;
    const parsedTeams = tnTeams.map(item => JSON.parse(item || "[]")).flat();
    //    // console.log("Teams in toernooien (geflatteerd):", parsedTeams.length, parsedTeams);
    //    // console.log("Teams[0]:", tnTeams[0].length, tnTeams[0]);
    // maak een set van teams die in toernooien voorkomen
    const teamsInToernooien = [...new Set(parsedTeams)].map(team => normalizeTeam(team)).sort();
    //    // console.log("Unieke teams in toernooien:", teamsInToernooien);
    // vergelijk de twee lijsten en verwijder teams die niet in toernooien voorkomen
    const teamsToDelete = teams.filter(team => !teamsInToernooien.includes(normalizeTeam(team)));
    //    // console.log("Te verwijderen teams:", teamsToDelete.length, teamsToDelete);

    if (teamsToDelete.length === 0) return [];

    for (const team of teamsToDelete) {
      const [sp1, sp2] = team.split("/");
      try {
        const [result] = await pool.execute(
          `DELETE kt FROM kraakTeams kt
           INNER JOIN spelers sp1 ON kt.speler1 = sp1.id
           INNER JOIN spelers sp2 ON kt.speler2 = sp2.id
           WHERE (sp1.naam = ? AND sp2.naam = ?) OR (sp1.naam = ? AND sp2.naam = ?)`,
          [sp1, sp2, sp2, sp1]
        );
      } catch (err) {
        console.error(`Fout bij verwijderen team ${team}:`, err);
      }
    }
    //    // console.log("Teams zonder toernooien verwijderd:", teamsToDelete);
    return teamsToDelete
  }

  // Normalise a team name so "A/B" and "B/A" are treated the same
  function normalizeTeam(teamName) {
    const [sp1, sp2] = teamName.split("/");
    return [sp1, sp2].sort().join("/");
  }

  // Insert a new team pair if it doesn't already exist; returns true if new
  async function isNewTeam(speler1Id, speler2Id) {
    // Zorg voor vaste volgorde (altijd laagste id eerst)
    const [id1, id2] = speler1Id < speler2Id
      ? [speler1Id, speler2Id]
      : [speler2Id, speler1Id];

    const [rows] = await pool.execute(
      `SELECT * FROM kraakTeams 
     WHERE (speler1 = ? AND speler2 = ?) OR (speler1 = ? AND speler2 = ?)`,
      [id1, id2, id2, id1]
    );
    if (rows.length > 0) return false;

    const [result] = await pool.execute(
      'INSERT INTO kraakTeams (speler1, speler2) VALUES (?, ?)',
      [id1, id2]
    );
    return true;
  }

  async function getNaamById(id) {
    const [rows] = await pool.execute("SELECT naam FROM spelers WHERE id = ?", [id]);
    return rows.length > 0 ? rows[0].naam : null;
  }

  app.get("/savedTeams", async (req, res) => {
    try {
    const [rows] = await pool.execute("SELECT * FROM kraakTeams");
    const teams = await Promise.all(rows.map(async row => ({
      team: `${await getNaamById(row.speler1)}/${await getNaamById(row.speler2)}`,
    })));
    teams.sort((a, b) => a.team.localeCompare(b.team));
    res.json(teams);
    } catch (error) {
      console.error("Fout bij ophalen savedTeams:", error);
      res.status(500).json({ error: "Interne serverfout" });
    }
  });

  app.post("/standardTeams", async (req, res) => {
    const { teams } = req.body;
    if (!teams || !Array.isArray(teams) || teams.length === 0) {
      return res.status(400).json({ error: 'teams is verplicht en moet een niet-lege array zijn' });
    }
    // eerst alle standaarTeams verwijderen
    // dan hebben we altijd een exacte kopie van de localStorage
    // en kunnen we de teams opnieuw invoeren
    // dit is nodig omdat de teams in de localStorage kunnen worden aangepast
    // en we willen niet dat de oude teams blijven staan
    // await pool.execute("DELETE FROM spelers");  
    // await pool.execute("DELETE FROM kraakTeams");

    const insertedTeamIds = [];
    for (const team of teams) {
      const [sp1Naam, sp2Naam] = team.players;
      if (!sp1Naam || !sp2Naam) continue;

      try {
        const sp1Id = await getOrCreatePlayer(sp1Naam);
        const sp2Id = await getOrCreatePlayer(sp2Naam);
        // isNewTeam voegt team toe als het niet bestaat
        // en retourneert true
        // anders false
        const teamExists = await isNewTeam(sp1Id, sp2Id);
        if (!teamExists) {
          insertedTeamIds.push({ spelers: [sp1Naam, sp2Naam] });
        }

      } catch (err) {
        console.error(`Fout bij verwerken team ${sp1Naam} & ${sp2Naam}:`, err);
      }
    }
    res.status(201).json({ insertedTeamIds });
  });

  app.get("/teams", async (req, res) => {
    try {
    const [rows] = await pool.execute("SELECT * FROM kraakTeams");
    res.json(rows);
    } catch (error) {
      console.error("Fout bij ophalen teams:", error);
      res.status(500).json({ error: "Interne serverfout" });
    }
  });

  app.get("/teamSpelers", async (req, res) => {
    try {
    const [rows] = await pool.execute(
      "SELECT teamID, team FROM teamSpelers ORDER BY team"
    );
    res.json(rows);
    } catch (error) {
      console.error("Fout bij ophalen teamSpelers:", error);
      res.status(500).json({ error: "Interne serverfout" });
    }
  });

  app.post("/results", async (req, res) => {
    const { toernooiID, ronde, groep, tafel, teamA, teamB, scoreA, scoreB } =
      req.body;
    const rij = await pool.execute(
      "SELECT * FROM kraakToernooiRondes WHERE toernooiID = ? && ronde = ? && groep = ? && tafel = ?",
      [toernooiID, ronde, groep, tafel]
    );
    if (rij[0].length > 0) {
      await pool.execute(
        "UPDATE kraakToernooiRondes SET scoreA = ?, scoreB = ? WHERE toernooiID = ? && ronde = ? && groep = ? && tafel = ?",
        [scoreA, scoreB, toernooiID, ronde, groep, tafel]
      );
    } else {
      await pool.execute(
        "INSERT INTO kraakToernooiRondes (toernooiID, ronde, groep, tafel, teamA, teamB, scoreA, scoreB) VALUES (?, ?, ?, ?,?, ?, ?, ?)",
        [toernooiID, ronde, groep, tafel, teamA, teamB, scoreA, scoreB]
      );
    }
    res.sendStatus(201);
  });

  app.get("/results", async (req, res) => {
    const toernooiID = req.query.toernooiID;
    if (!toernooiID) {
      return res.status(400).json({ error: "toernooiID is verplicht" });
    }
    let sqlStr =
      "SELECT tn.id AS toernooiID, tn.datum, ktr.ronde, ktr.groep, ktr.tafel, ";
    sqlStr +=
      " ktr.teamA, ktr.scoreA, ktr.teamB, ktr.scoreB FROM kraakToernooiRondes ktr ";
    sqlStr += " JOIN kraaktoernooien tn ON tn.id = ktr.toernooiID ";
    sqlStr += " WHERE tn.id = ? ";
    sqlStr += " ORDER BY tn.datum, ktr.ronde, ktr.groep, ktr.tafel";
    //    // console.log("SQL:", sqlStr);
    const [rows] = await pool.execute(sqlStr, [toernooiID]);
    if (rows.length === 0) {
      return res
        .status(404)
        .json({ error: "Geen resultaten gevonden voor dit toernooi" });
    }

    const results = rows.map((row) => ({
      datum: row.datum,
      ronde: row.ronde,
      groep: row.groep,
      tafel: row.tafel,
      teamA: row.teamA,
      scoreA: row.scoreA,
      teamB: row.teamB,
      scoreB: row.scoreB,
    }));
    res.json(results);
  });

  const port = process.env.PORT;
  app.listen(port, () =>
    console.log(`Server draait op http://localhost:${port}`));
};
// Roep één keer aan bij opstarten
cleanupTmpFolder();


start();
