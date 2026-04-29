const mysql = require('mysql2/promise');

async function updateDb() {
    const connection = await mysql.createConnection({
        host: 'localhost',
        user: 'root',
        password: 'root123', 
        database: 'internationaldb'
    });

    try {
        console.log('Adding is_spouse column...');
        try { await connection.query("ALTER TABLE application_language_tests ADD COLUMN is_spouse TINYINT(1) DEFAULT 0"); } catch(e) {}
        try { await connection.query("ALTER TABLE registration_language_tests ADD COLUMN is_spouse TINYINT(1) DEFAULT 0"); } catch(e) {}

        console.log('Updating sp_AddApplicationLangTest...');
        await connection.query("DROP PROCEDURE IF EXISTS sp_AddApplicationLangTest");
        await connection.query(`
            CREATE PROCEDURE sp_AddApplicationLangTest(
                IN p_application_id INT, IN p_type VARCHAR(50), IN p_reading VARCHAR(20), 
                IN p_writing VARCHAR(20), IN p_speaking VARCHAR(20), IN p_listening VARCHAR(20), 
                IN p_overall VARCHAR(20), IN p_is_spouse TINYINT(1)
            )
            BEGIN
                INSERT INTO application_language_tests (application_id, test_type, reading, writing, speaking, listening, overall, is_spouse)
                VALUES (p_application_id, p_type, p_reading, p_writing, p_speaking, p_listening, p_overall, p_is_spouse);
            END
        `);

        console.log('Updating sp_AddRegistrationLangTest...');
        await connection.query("DROP PROCEDURE IF EXISTS sp_AddRegistrationLangTest");
        await connection.query(`
            CREATE PROCEDURE sp_AddRegistrationLangTest(
                IN p_registration_id INT, IN p_type VARCHAR(50), IN p_reading VARCHAR(20), 
                IN p_writing VARCHAR(20), IN p_speaking VARCHAR(20), IN p_listening VARCHAR(20), 
                IN p_overall VARCHAR(20), IN p_is_spouse TINYINT(1)
            )
            BEGIN
                INSERT INTO registration_language_tests (registration_id, test_type, reading, writing, speaking, listening, overall, is_spouse)
                VALUES (p_registration_id, p_type, p_reading, p_writing, p_speaking, p_listening, p_overall, p_is_spouse);
            END
        `);

        console.log('Database updated successfully!');
    } catch (err) {
        console.error('Error updating database:', err);
    } finally {
        await connection.end();
    }
}

updateDb();
