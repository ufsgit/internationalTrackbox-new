const mysql = require('mysql2');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '../.env') });

const connection = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME
});

console.log('Connecting to database:', process.env.DB_NAME);

connection.query(`
    SELECT COLUMN_NAME 
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_SCHEMA = ? AND TABLE_NAME = 'suggested_programs' AND COLUMN_NAME = 'created_at'
`, [process.env.DB_NAME], (err, results) => {
    if (err) {
        console.error('Error checking columns:', err);
        process.exit(1);
    }
    
    if (results.length === 0) {
        console.log('Adding created_at to suggested_programs...');
        connection.query(`
            ALTER TABLE suggested_programs 
            ADD COLUMN created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
        `, (err) => {
            if (err) console.error('Error altering suggested_programs:', err);
            else console.log('Successfully altered suggested_programs!');
            checkRegTable();
        });
    } else {
        console.log('created_at already exists in suggested_programs.');
        checkRegTable();
    }
});

function checkRegTable() {
    connection.query(`
        SELECT COLUMN_NAME 
        FROM INFORMATION_SCHEMA.COLUMNS 
        WHERE TABLE_SCHEMA = ? AND TABLE_NAME = 'registration_suggested_programs' AND COLUMN_NAME = 'created_at'
    `, [process.env.DB_NAME], (err, results) => {
        if (err) {
            console.error('Error checking columns:', err);
            process.exit(1);
        }
        
        if (results.length === 0) {
            console.log('Adding created_at to registration_suggested_programs...');
            connection.query(`
                ALTER TABLE registration_suggested_programs 
                ADD COLUMN created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
            `, (err) => {
                if (err) console.error('Error altering registration_suggested_programs:', err);
                else console.log('Successfully altered registration_suggested_programs!');
                connection.end();
            });
        } else {
            console.log('created_at already exists in registration_suggested_programs.');
            connection.end();
        }
    });
}
