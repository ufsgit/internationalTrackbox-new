require('dotenv').config();
const db = require('../src/config/db');

async function main() {
    try {
        console.log('Adding details2 and details3 columns to suggested_programs...');
        await db.promise().query(`ALTER TABLE suggested_programs 
            ADD COLUMN details2 VARCHAR(255) DEFAULT NULL AFTER details,
            ADD COLUMN details3 VARCHAR(255) DEFAULT NULL AFTER details2`);
        console.log('Successfully added details2 and details3 to suggested_programs.');
    } catch (err) {
        if (err.code === 'ER_DUP_FIELDNAME') {
            console.log('Columns already exist in suggested_programs.');
        } else {
            console.error('Error altering suggested_programs:', err);
        }
    }

    try {
        console.log('Adding details2 and details3 columns to registration_suggested_programs...');
        await db.promise().query(`ALTER TABLE registration_suggested_programs 
            ADD COLUMN details2 VARCHAR(255) DEFAULT NULL AFTER details,
            ADD COLUMN details3 VARCHAR(255) DEFAULT NULL AFTER details2`);
        console.log('Successfully added details2 and details3 to registration_suggested_programs.');
    } catch (err) {
        if (err.code === 'ER_DUP_FIELDNAME') {
            console.log('Columns already exist in registration_suggested_programs.');
        } else {
            console.error('Error altering registration_suggested_programs:', err);
        }
    }

    process.exit(0);
}

main();
