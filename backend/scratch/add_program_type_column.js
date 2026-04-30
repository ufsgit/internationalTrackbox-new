require('dotenv').config({ path: require('path').join(__dirname, '../.env') });
const db = require('../src/config/db.js');

const alterTables = async () => {
    try {
        console.log('Checking for program_type column in suggested_programs...');
        const [cols1] = await db.promise().query("SHOW COLUMNS FROM suggested_programs LIKE 'program_type'");
        if (cols1.length === 0) {
            console.log('Adding program_type column to suggested_programs...');
            await db.promise().query(`ALTER TABLE suggested_programs ADD COLUMN program_type VARCHAR(50) AFTER application_id`);
        } else {
            console.log('program_type already exists in suggested_programs.');
        }

        console.log('Checking for program_type column in registration_suggested_programs...');
        const [cols2] = await db.promise().query("SHOW COLUMNS FROM registration_suggested_programs LIKE 'program_type'");
        if (cols2.length === 0) {
            console.log('Adding program_type column to registration_suggested_programs...');
            await db.promise().query(`ALTER TABLE registration_suggested_programs ADD COLUMN program_type VARCHAR(50) AFTER registration_id`);
        } else {
            console.log('program_type already exists in registration_suggested_programs.');
        }

        console.log('Database migration completed successfully.');
        process.exit(0);
    } catch (error) {
        console.error('Migration failed:', error);
        process.exit(1);
    }
};

alterTables();
