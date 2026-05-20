require('dotenv').config();
const db = require('../src/config/db');

async function main() {
    try {
        console.log('--- DEFINITION OF sp_DeleteApplicationChildrenFull ---');
        const [res1] = await db.promise().query('SHOW CREATE PROCEDURE sp_DeleteApplicationChildrenFull');
        console.log(res1[0]['Create Procedure']);

        console.log('\n--- DEFINITION OF sp_DeleteRegistrationChildrenFull ---');
        const [res2] = await db.promise().query('SHOW CREATE PROCEDURE sp_DeleteRegistrationChildrenFull');
        console.log(res2[0]['Create Procedure']);
        
    } catch (err) {
        console.error('Error fetching SP definition:', err);
    }
    process.exit(0);
}

main();
