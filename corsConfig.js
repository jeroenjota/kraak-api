const devOrigins = [
  'http://localhost:5173',
  'http://localhost:3000',
];

const prodOrigins = [
  'https://www.jota.nl',
  'https://api.jota.nl',
];

export function corsOptions() {
  const allowedOrigins =
    process.env.NODE_ENV === 'production'
      ? prodOrigins
      : devOrigins;

  return {
    origin(origin, callback) {
      // allow server-to-server & curl
      if (!origin || allowedOrigins.includes(origin)) {
        callback(null, true);
      } else {
        callback(new Error('CORS not allowed'));
      }
    },
    credentials: true,
  };
}
