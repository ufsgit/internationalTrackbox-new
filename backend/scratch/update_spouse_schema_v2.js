const db = require('../src/config/db.js');

const alterTables = [
    "ALTER TABLE application_spouse_education ADD COLUMN edu_type VARCHAR(20) AFTER expected_completion",
    "ALTER TABLE registration_spouse_education ADD COLUMN edu_type VARCHAR(20) AFTER expected_completion",
    "ALTER TABLE application_spouse_work ADD COLUMN work_type VARCHAR(20) AFTER work_months",
    "ALTER TABLE registration_spouse_work ADD COLUMN work_type VARCHAR(20) AFTER work_months"
];

const updateProcedures = [
    `DROP PROCEDURE IF EXISTS sp_AddApplicationSpouseEdu;`,
    `CREATE PROCEDURE sp_AddApplicationSpouseEdu(
        IN p_app_id INT,
        IN p_country VARCHAR(100),
        IN p_level VARCHAR(100),
        IN p_field VARCHAR(100),
        IN p_status VARCHAR(50),
        IN p_expected_completion DATE,
        IN p_edu_type VARCHAR(20)
    )
    BEGIN
        INSERT INTO application_spouse_education (application_id, country, level, field, status, expected_completion, edu_type)
        VALUES (p_app_id, p_country, p_level, p_field, p_status, p_expected_completion, p_edu_type);
    END`,

    `DROP PROCEDURE IF EXISTS sp_AddRegistrationSpouseEdu;`,
    `CREATE PROCEDURE sp_AddRegistrationSpouseEdu(
        IN p_reg_id INT,
        IN p_country VARCHAR(100),
        IN p_level VARCHAR(100),
        IN p_field VARCHAR(100),
        IN p_status VARCHAR(50),
        IN p_expected_completion DATE,
        IN p_edu_type VARCHAR(20)
    )
    BEGIN
        INSERT INTO registration_spouse_education (registration_id, country, level, field, status, expected_completion, edu_type)
        VALUES (p_reg_id, p_country, p_level, p_field, p_status, p_expected_completion, p_edu_type);
    END`,

    `DROP PROCEDURE IF EXISTS sp_AddApplicationSpouseWork;`,
    `CREATE PROCEDURE sp_AddApplicationSpouseWork(
        IN p_app_id INT,
        IN p_country VARCHAR(100),
        IN p_job_title VARCHAR(255),
        IN p_work_years INT,
        IN p_work_months INT,
        IN p_work_type VARCHAR(20)
    )
    BEGIN
        INSERT INTO application_spouse_work (application_id, country, job_title, work_years, work_months, work_type)
        VALUES (p_app_id, p_country, p_job_title, p_work_years, p_work_months, p_work_type);
    END`,

    `DROP PROCEDURE IF EXISTS sp_AddRegistrationSpouseWork;`,
    `CREATE PROCEDURE sp_AddRegistrationSpouseWork(
        IN p_reg_id INT,
        IN p_country VARCHAR(100),
        IN p_job_title VARCHAR(255),
        IN p_work_years INT,
        IN p_work_months INT,
        IN p_work_type VARCHAR(20)
    )
    BEGIN
        INSERT INTO registration_spouse_work (registration_id, country, job_title, work_years, work_months, work_type)
        VALUES (p_reg_id, p_country, p_job_title, p_work_years, p_work_months, p_work_type);
    END`
];

(async () => {
    const pDb = db.promise();
    try {
        console.log("Altering tables...");
        for (const sql of alterTables) {
            try {
                await pDb.query(sql);
                console.log(`Success: ${sql}`);
            } catch (err) {
                if (err.code === 'ER_DUP_COLUMN_NAME') {
                    console.log(`Column already exists: ${sql.split(' ')[2]}`);
                } else {
                    console.error(`Error altering table: ${err.message}`);
                }
            }
        }

        console.log("Updating procedures...");
        for (const sql of updateProcedures) {
            await pDb.query(sql);
            console.log("Executed procedure update step.");
        }
        console.log("Database updates complete.");
    } catch (err) {
        console.error("Critical error:", err);
    } finally {
        process.exit(0);
    }
})();
