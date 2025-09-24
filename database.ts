import mysql from 'mysql2/promise';

export const db = await mysql.createConnection({
  host: 'localhost',
  user: 'code_user',
  password: 'holy96H@',
  database: 'code_db'
});

console.log('Connecté à MySQL avec succès !');
