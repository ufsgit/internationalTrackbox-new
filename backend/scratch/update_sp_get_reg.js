const mysql = require('mysql2/promise');

async function updateSP() {
    const connection = await mysql.createConnection({
        host: 'localhost',
        user: 'root',
        password: 'root123',
        database: 'internationaldb',
        multipleStatements: true
    });

    try {
        const sql = `
            DROP PROCEDURE IF EXISTS sp_GetStudentRegistration;
            CREATE PROCEDURE sp_GetStudentRegistration(IN p_student_id INT)
            BEGIN
                -- Result 1: Core Registration Data
                SELECT * FROM student_registrations WHERE student_id = p_student_id LIMIT 1;
                
                -- Result 2: Education
                SELECT e.* FROM registration_education e
                JOIN student_registrations r ON e.registration_id = r.registration_id
                WHERE r.student_id = p_student_id;
                
                -- Result 3: Work Experience
                SELECT w.* FROM registration_work_experience w
                JOIN student_registrations r ON w.registration_id = r.registration_id
                WHERE r.student_id = p_student_id;
                
                -- Result 4: Language Tests
                SELECT t.* FROM registration_language_tests t
                JOIN student_registrations r ON t.registration_id = r.registration_id
                WHERE r.student_id = p_student_id;
                
                -- Result 5: Children
                SELECT c.* FROM registration_children c
                JOIN student_registrations r ON c.registration_id = r.registration_id
                WHERE r.student_id = p_student_id;
                
                -- Result 6: Suggested Programs
                SELECT s.* FROM registration_suggested_programs s
                JOIN student_registrations r ON s.registration_id = r.registration_id
                WHERE r.student_id = p_student_id;

                -- Result 7: Spouse Education
                SELECT e.* FROM registration_spouse_education e
                JOIN student_registrations r ON e.registration_id = r.registration_id
                WHERE r.student_id = p_student_id;

                -- Result 8: Spouse Work
                SELECT w.* FROM registration_spouse_work w
                JOIN student_registrations r ON w.registration_id = r.registration_id
                WHERE r.student_id = p_student_id;

                -- Result 9: Relatives
                SELECT rel.* FROM registration_relatives rel
                JOIN student_registrations r ON rel.registration_id = r.registration_id
                WHERE r.student_id = p_student_id;
            END;
        `;
        await connection.query(sql);
        console.log('SP sp_GetStudentRegistration updated successfully');
    } catch (err) {
        console.error('Error updating SP:', err);
    } finally {
        await connection.end();
    }
}

updateSP();
