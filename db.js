/**
 * db.js – MySQL connection pool.
 * Creates a mysql2/promise pool using credentials from .env.
 * Shared by all server route handlers.
 */
import dotenv from "dotenv";
import mysql from "mysql2/promise";
dotenv.config();

const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  connectionLimit: 10,
});

console.log("MySQL connection pool created with the following configuration:");
console.log(`Host: ${process.env.DB_HOST}`);
console.log(`User: ${process.env.DB_USER}`);
console.log(`Database: ${process.env.DB_NAME}`);
console.log(`Connection Limit: 10`);

export default pool;
