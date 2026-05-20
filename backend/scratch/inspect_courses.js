const mysql = require('mysql2/promise');
require('dotenv').config();

async function run() {
    const db = await mysql.createConnection({
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASS,
        database: process.env.DB_NAME
    });

    try {
        const [rows] = await db.query("DESCRIBE registration_suggested_programs");
        console.log("registration_suggested_programs:", rows.map(r => `${r.Field}: ${r.Type}`));
        
        const [rows2] = await db.query("DESCRIBE student_suggested_programs");
        console.log("student_suggested_programs:", rows2.map(r => `${r.Field}: ${r.Type}`));
    } catch (err) {
        console.error(err);
    } finally {
        await db.end();
    }
}
run();
