const mysql = require('mysql2/promise');

async function updateDb() {
    const connection = await mysql.createConnection({
        host: 'localhost',
        user: 'root',
        password: 'root123',
        database: 'internationaldb'
    });

    try {
        console.log('Adding edu_type column...');
        try { await connection.query("ALTER TABLE application_education ADD COLUMN edu_type VARCHAR(20) DEFAULT 'highest'"); } catch(e) {}
        try { await connection.query("ALTER TABLE registration_education ADD COLUMN edu_type VARCHAR(20) DEFAULT 'highest'"); } catch(e) {}

        console.log('Updating sp_AddApplicationEducation...');
        await connection.query("DROP PROCEDURE IF EXISTS sp_AddApplicationEducation");
        await connection.query(`
            CREATE PROCEDURE sp_AddApplicationEducation(
                IN p_application_id INT, IN p_country VARCHAR(100), IN p_level VARCHAR(100), 
                IN p_field VARCHAR(100), IN p_status VARCHAR(50), IN p_expected_completion DATE, 
                IN p_is_highest TINYINT(1), IN p_edu_type VARCHAR(20)
            )
            BEGIN
                INSERT INTO application_education (application_id, country, level, field, status, expected_completion, is_highest, edu_type)
                VALUES (p_application_id, p_country, p_level, p_field, p_status, p_expected_completion, p_is_highest, p_edu_type);
            END
        `);

        console.log('Updating sp_AddRegistrationEducation...');
        await connection.query("DROP PROCEDURE IF EXISTS sp_AddRegistrationEducation");
        await connection.query(`
            CREATE PROCEDURE sp_AddRegistrationEducation(
                IN p_registration_id INT, IN p_country VARCHAR(100), IN p_level VARCHAR(100), 
                IN p_field VARCHAR(100), IN p_status VARCHAR(50), IN p_expected_completion DATE, 
                IN p_is_highest TINYINT(1), IN p_edu_type VARCHAR(20)
            )
            BEGIN
                INSERT INTO registration_education (registration_id, country, level, field, status, expected_completion, is_highest, edu_type)
                VALUES (p_registration_id, p_country, p_level, p_field, p_status, p_expected_completion, p_is_highest, p_edu_type);
            END
        `);

        console.log('Database updated successfully with edu_type!');
    } catch (err) {
        console.error('Error updating database:', err);
    } finally {
        await connection.end();
    }
}

updateDb();
