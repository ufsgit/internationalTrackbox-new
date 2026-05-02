const mysql = require('mysql2');
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root123',
    database: 'internationaldb'
});

db.connect(err => {
    if (err) {
        console.error(err);
        process.exit(1);
    }
    const sql = `
CREATE PROCEDURE sp_AddRegistrationAdmissionTest(
    IN p_registration_id INT, 
    IN p_type VARCHAR(50), 
    IN p_quant VARCHAR(20), 
    IN p_verbal VARCHAR(20), 
    IN p_data_insights VARCHAR(20), 
    IN p_overall VARCHAR(20)
)
BEGIN
    INSERT INTO registration_admission_tests (registration_id, test_type, quant, verbal, data_insights, overall)
    VALUES (p_registration_id, p_type, p_quant, p_verbal, p_data_insights, p_overall);
END`;

    db.query(sql, (err, rows) => {
        if (err) {
            console.error(err);
        } else {
            console.log('Successfully created sp_AddRegistrationAdmissionTest');
        }
        db.end();
    });
});
