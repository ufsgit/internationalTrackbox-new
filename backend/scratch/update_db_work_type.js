const mysql = require('mysql2/promise');

async function updateDb() {
    const connection = await mysql.createConnection({
        host: 'localhost',
        user: 'root',
        password: 'root123',
        database: 'internationaldb'
    });

    try {
        console.log('Adding work_type column...');
        try { await connection.query("ALTER TABLE application_work_experience ADD COLUMN work_type VARCHAR(20) DEFAULT 'curr_country'"); } catch(e) {}
        try { await connection.query("ALTER TABLE registration_work_experience ADD COLUMN work_type VARCHAR(20) DEFAULT 'curr_country'"); } catch(e) {}

        console.log('Updating sp_AddApplicationWork...');
        await connection.query("DROP PROCEDURE IF EXISTS sp_AddApplicationWork");
        await connection.query(`
            CREATE PROCEDURE sp_AddApplicationWork(
                IN p_application_id INT, IN p_country VARCHAR(100), IN p_job_title VARCHAR(100), 
                IN p_work_years INT, IN p_work_months INT, IN p_is_current TINYINT(1),
                IN p_work_type VARCHAR(20)
            )
            BEGIN
                INSERT INTO application_work_experience (application_id, country, job_title, work_years, work_months, is_current, work_type)
                VALUES (p_application_id, p_country, p_job_title, p_work_years, p_work_months, p_is_current, p_work_type);
            END
        `);

        console.log('Updating sp_AddRegistrationWork...');
        await connection.query("DROP PROCEDURE IF EXISTS sp_AddRegistrationWork");
        await connection.query(`
            CREATE PROCEDURE sp_AddRegistrationWork(
                IN p_registration_id INT, IN p_country VARCHAR(100), IN p_job_title VARCHAR(100), 
                IN p_work_years INT, IN p_work_months INT, IN p_work_category VARCHAR(20),
                IN p_work_type VARCHAR(20)
            )
            BEGIN
                -- Note: registration table uses work_category instead of is_current in some schemas, 
                -- but we will stick to the provided pattern.
                INSERT INTO registration_work_experience (registration_id, country, job_title, work_years, work_months, work_category, work_type)
                VALUES (p_registration_id, p_country, p_job_title, p_work_years, p_work_months, p_work_category, p_work_type);
            END
        `);

        console.log('Database updated successfully with work_type!');
    } catch (err) {
        console.error('Error updating database:', err);
    } finally {
        await connection.end();
    }
}

updateDb();
