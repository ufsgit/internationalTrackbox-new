const mysql = require('mysql2');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '../.env') });

const connection = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    multipleStatements: true
});

const spApp = `
DROP PROCEDURE IF EXISTS sp_DeleteApplicationChildrenFull;
CREATE PROCEDURE sp_DeleteApplicationChildrenFull(IN p_application_id INT)
BEGIN
    DELETE FROM application_education WHERE application_id = p_application_id;
    DELETE FROM application_work_experience WHERE application_id = p_application_id;
    DELETE FROM application_language_tests WHERE application_id = p_application_id;
    DELETE FROM application_admission_tests WHERE application_id = p_application_id;
    DELETE FROM application_spouse_education WHERE application_id = p_application_id;
    DELETE FROM application_spouse_work WHERE application_id = p_application_id;
    DELETE FROM application_relatives WHERE application_id = p_application_id;
    DELETE FROM application_children WHERE application_id = p_application_id;
END;
`;

const spReg = `
DROP PROCEDURE IF EXISTS sp_DeleteRegistrationChildrenFull;
CREATE PROCEDURE sp_DeleteRegistrationChildrenFull(IN p_registration_id INT)
BEGIN
    DELETE FROM registration_education WHERE registration_id = p_registration_id;
    DELETE FROM registration_work_experience WHERE registration_id = p_registration_id;
    DELETE FROM registration_language_tests WHERE registration_id = p_registration_id;
    DELETE FROM registration_admission_tests WHERE registration_id = p_registration_id;
    DELETE FROM registration_spouse_education WHERE registration_id = p_registration_id;
    DELETE FROM registration_spouse_work WHERE registration_id = p_registration_id;
    DELETE FROM registration_relatives WHERE registration_id = p_registration_id;
    DELETE FROM registration_children WHERE registration_id = p_registration_id;
END;
`;

connection.query(spApp, (err) => {
    if (err) { console.error('Error patching App SP:', err); process.exit(1); }
    console.log('Successfully patched sp_DeleteApplicationChildrenFull');
    
    connection.query(spReg, (err) => {
        if (err) { console.error('Error patching Reg SP:', err); process.exit(1); }
        console.log('Successfully patched sp_DeleteRegistrationChildrenFull');
        connection.end();
    });
});
