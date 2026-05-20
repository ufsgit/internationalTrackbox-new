require('dotenv').config();
const db = require('../src/config/db');

async function main() {
    try {
        console.log('Adding issystem column to suggested_programs...');
        await db.promise().query(`ALTER TABLE suggested_programs ADD COLUMN issystem TINYINT(1) DEFAULT 0 AFTER application_id`);
        console.log('Successfully added issystem to suggested_programs.');
    } catch (err) {
        if (err.code === 'ER_DUP_FIELDNAME') {
            console.log('issystem already exists in suggested_programs.');
        } else {
            console.error('Error altering suggested_programs:', err);
        }
    }

    try {
        console.log('Adding issystem column to registration_suggested_programs...');
        await db.promise().query(`ALTER TABLE registration_suggested_programs ADD COLUMN issystem TINYINT(1) DEFAULT 0 AFTER registration_id`);
        console.log('Successfully added issystem to registration_suggested_programs.');
    } catch (err) {
        if (err.code === 'ER_DUP_FIELDNAME') {
            console.log('issystem already exists in registration_suggested_programs.');
        } else {
            console.error('Error altering registration_suggested_programs:', err);
        }
    }

    process.exit(0);
}

main();
