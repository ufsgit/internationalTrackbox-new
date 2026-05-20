require('dotenv').config();
const db = require('../src/config/db');

async function main() {
    try {
        console.log('--- COLUMNS IN student_applications ---');
        const [cols1] = await db.promise().query('DESCRIBE student_applications');
        cols1.forEach(c => console.log(`- ${c.Field}: ${c.Type} (Null: ${c.Null}, Key: ${c.Key})`));

        console.log('\n--- COLUMNS IN student_registrations ---');
        const [cols2] = await db.promise().query('DESCRIBE student_registrations');
        cols2.forEach(c => console.log(`- ${c.Field}: ${c.Type} (Null: ${c.Null}, Key: ${c.Key})`));
        
    } catch (err) {
        console.error('Error fetching columns:', err);
    }
    process.exit(0);
}

main();
