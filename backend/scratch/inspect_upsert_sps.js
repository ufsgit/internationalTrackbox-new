require('dotenv').config();
const db = require('../src/config/db');

async function main() {
    try {
        console.log('--- DEFINITION OF sp_UpsertStudentApplication_Core ---');
        const [res1] = await db.promise().query('SHOW CREATE PROCEDURE sp_UpsertStudentApplication_Core');
        console.log(res1[0]['Create Procedure']);

        console.log('\n--- DEFINITION OF sp_UpsertStudentRegistration_Core ---');
        const [res2] = await db.promise().query('SHOW CREATE PROCEDURE sp_UpsertStudentRegistration_Core');
        console.log(res2[0]['Create Procedure']);
        
    } catch (err) {
        console.error('Error:', err);
    }
    process.exit(0);
}

main();
