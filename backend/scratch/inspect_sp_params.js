require('dotenv').config();
const db = require('../src/config/db');

async function main() {
    try {
        const [res1] = await db.promise().query('SHOW CREATE PROCEDURE sp_UpsertStudentApplication_Core');
        const lines1 = res1[0]['Create Procedure'].split('\n');
        console.log('--- sp_UpsertStudentApplication_Core Params ---');
        lines1.slice(0, 30).forEach(l => console.log(l));

        const [res2] = await db.promise().query('SHOW CREATE PROCEDURE sp_UpsertStudentRegistration_Core');
        const lines2 = res2[0]['Create Procedure'].split('\n');
        console.log('\n--- sp_UpsertStudentRegistration_Core Params ---');
        lines2.slice(0, 30).forEach(l => console.log(l));
    } catch (err) {
        console.error('Error:', err);
    }
    process.exit(0);
}

main();
