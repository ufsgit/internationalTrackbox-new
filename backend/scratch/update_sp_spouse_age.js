const db = require('../src/config/db.js');

const alterAppSP = `
DROP PROCEDURE IF EXISTS sp_UpsertStudentApplication_Core;
`;
const createAppSP = `
CREATE PROCEDURE sp_UpsertStudentApplication_Core(
    IN p_student_id INT,
    IN p_passport_name VARCHAR(255),
    IN p_age INT,
    IN p_dob DATE,
    IN p_gender ENUM('Male','Female','Other'),
    IN p_marital_status VARCHAR(50),
    IN p_spouse_accompanying TINYINT(1),
    IN p_address_country VARCHAR(100),
    IN p_address_state VARCHAR(100),
    IN p_address_suburb VARCHAR(100),
    IN p_contact1_code VARCHAR(10),
    IN p_contact1 VARCHAR(50),
    IN p_contact2_code VARCHAR(10),
    IN p_contact2 VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_citizenship_country VARCHAR(100),
    IN p_passport_country VARCHAR(100),
    IN p_has_second_passport TINYINT(1),
    IN p_second_passport_country VARCHAR(100),
    IN p_highest_education VARCHAR(100),
    IN p_education_field VARCHAR(100),
    IN p_spouse_age INT
)
BEGIN
    INSERT INTO student_applications (
        student_id, passport_name, age, dob, gender, marital_status, spouse_accompanying,
        address_country, address_state, address_suburb, contact1_code, contact1,
        contact2_code, contact2, email, citizenship_country, passport_country,
        has_second_passport, second_passport_country, highest_education, education_field,
        spouse_age
    )
    VALUES (
        p_student_id, p_passport_name, p_age, p_dob, p_gender, p_marital_status, p_spouse_accompanying,
        p_address_country, p_address_state, p_address_suburb, p_contact1_code, p_contact1,
        p_contact2_code, p_contact2, p_email, p_citizenship_country, p_passport_country,
        p_has_second_passport, p_second_passport_country, p_highest_education, p_education_field,
        p_spouse_age
    )
    ON DUPLICATE KEY UPDATE
        passport_name = VALUES(passport_name),
        age = VALUES(age),
        dob = VALUES(dob),
        gender = VALUES(gender),
        marital_status = VALUES(marital_status),
        spouse_accompanying = VALUES(spouse_accompanying),
        address_country = VALUES(address_country),
        address_state = VALUES(address_state),
        address_suburb = VALUES(address_suburb),
        contact1 = VALUES(contact1),
        contact2 = VALUES(contact2),
        email = VALUES(email),
        spouse_age = VALUES(spouse_age),
        updated_at = CURRENT_TIMESTAMP;
    
    SELECT application_id AS app_id FROM student_applications WHERE student_id = p_student_id ORDER BY created_at DESC LIMIT 1;
END
`;

const alterRegSP = `
DROP PROCEDURE IF EXISTS sp_UpsertStudentRegistration_Core;
`;
const createRegSP = `
CREATE PROCEDURE sp_UpsertStudentRegistration_Core(
    IN p_student_id INT,
    IN p_passport_name VARCHAR(255),
    IN p_first_name VARCHAR(100),
    IN p_last_name VARCHAR(100),
    IN p_age INT,
    IN p_dob DATE,
    IN p_gender ENUM('Male','Female','Other'),
    IN p_marital_status VARCHAR(50),
    IN p_spouse_accompanying TINYINT(1),
    IN p_address_country VARCHAR(100),
    IN p_address_state VARCHAR(100),
    IN p_address_suburb VARCHAR(100),
    IN p_address_postcode VARCHAR(20),
    IN p_contact1_code VARCHAR(10),
    IN p_contact1 VARCHAR(50),
    IN p_contact2_code VARCHAR(10),
    IN p_contact2 VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_citizenship_country VARCHAR(100),
    IN p_passport_country VARCHAR(100),
    IN p_has_second_passport TINYINT(1),
    IN p_second_passport_country VARCHAR(100),
    IN p_highest_education VARCHAR(100),
    IN p_education_field VARCHAR(100),
    IN p_spouse_age INT
)
BEGIN
    INSERT INTO student_registrations (
        student_id, passport_name, first_name, last_name, age, dob, gender, marital_status, spouse_accompanying,
        address_country, address_state, address_suburb, address_postcode, contact1_code, contact1,
        contact2_code, contact2, email, citizenship_country, passport_country,
        has_second_passport, second_passport_country, highest_education, education_field,
        spouse_age
    )
    VALUES (
        p_student_id, p_passport_name, p_first_name, p_last_name, p_age, p_dob, p_gender, p_marital_status, p_spouse_accompanying,
        p_address_country, p_address_state, p_address_suburb, p_address_postcode, p_contact1_code, p_contact1,
        p_contact2_code, p_contact2, p_email, p_citizenship_country, p_passport_country,
        p_has_second_passport, p_second_passport_country, p_highest_education, p_education_field,
        p_spouse_age
    )
    ON DUPLICATE KEY UPDATE
        passport_name = VALUES(passport_name),
        first_name = VALUES(first_name),
        last_name = VALUES(last_name),
        age = VALUES(age),
        dob = VALUES(dob),
        gender = VALUES(gender),
        marital_status = VALUES(marital_status),
        spouse_accompanying = VALUES(spouse_accompanying),
        address_country = VALUES(address_country),
        address_state = VALUES(address_state),
        address_suburb = VALUES(address_suburb),
        address_postcode = VALUES(address_postcode),
        contact1 = VALUES(contact1),
        contact2 = VALUES(contact2),
        email = VALUES(email),
        spouse_age = VALUES(spouse_age),
        updated_at = CURRENT_TIMESTAMP;
    
    SELECT registration_id AS reg_id FROM student_registrations WHERE student_id = p_student_id ORDER BY created_at DESC LIMIT 1;
END
`;

(async () => {
    try {
        await db.promise().query(alterAppSP);
        await db.promise().query(createAppSP);
        console.log("sp_UpsertStudentApplication_Core updated.");
        
        await db.promise().query(alterRegSP);
        await db.promise().query(createRegSP);
        console.log("sp_UpsertStudentRegistration_Core updated.");
    } catch(err) {
        console.error(err);
    } finally {
        process.exit(0);
    }
})();
