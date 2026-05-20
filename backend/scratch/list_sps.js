require('dotenv').config();
const db = require('../src/config/db');

async function main() {
    try {
        console.log('--- STORED PROCEDURES CONTAINING suggested OR program ---');
        const [rows] = await db.promise().query("SHOW PROCEDURE STATUS WHERE Db = DATABASE() AND (Name LIKE '%suggested%' OR Name LIKE '%program%')");
        if (rows.length === 0) {
            console.log('No matching stored procedures found.');
        } else {
            rows.forEach(r => console.log(`- ${r.Name}`));
        }
    } catch (err) {
        console.error('Error fetching SP list:', err);
    }
    process.exit(0);
}

main();
