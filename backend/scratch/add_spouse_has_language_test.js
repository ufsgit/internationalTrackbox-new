require('dotenv').config();
const db = require('../src/config/db');

async function main() {
    const connection = db.promise();
    try {
        console.log('1. Checking and adding spouse_has_language_test column...');
        
        // Add column to student_applications
        const [appCols] = await connection.query('DESCRIBE student_applications');
        if (!appCols.some(c => c.Field === 'spouse_has_language_test')) {
            await connection.query('ALTER TABLE student_applications ADD COLUMN spouse_has_language_test TINYINT(1) DEFAULT NULL AFTER spouse_age');
            console.log('✅ Added spouse_has_language_test column to student_applications.');
        } else {
            console.log('ℹ️ Column spouse_has_language_test already exists in student_applications.');
        }

        // Add column to student_registrations
        const [regCols] = await connection.query('DESCRIBE student_registrations');
        if (!regCols.some(c => c.Field === 'spouse_has_language_test')) {
            await connection.query('ALTER TABLE student_registrations ADD COLUMN spouse_has_language_test TINYINT(1) DEFAULT NULL AFTER spouse_age');
            console.log('✅ Added spouse_has_language_test column to student_registrations.');
        } else {
            console.log('ℹ️ Column spouse_has_language_test already exists in student_registrations.');
        }

        console.log('\n2. Updating Stored Procedure sp_UpsertStudentApplication_Core...');
        await connection.query('DROP PROCEDURE IF EXISTS sp_UpsertStudentApplication_Core');
        await connection.query(`
            CREATE PROCEDURE sp_UpsertStudentApplication_Core(
                IN p_student_id INT,
                IN p_passport_name VARCHAR(255),
                IN p_age INT,
                IN p_dob DATE,
                IN p_gender VARCHAR(50),
                IN p_marital_status VARCHAR(50),
                IN p_spouse_accompanying TINYINT(1),
                IN p_address_country VARCHAR(255),
                IN p_address_state VARCHAR(255),
                IN p_address_suburb VARCHAR(255),
                IN p_contact1_code VARCHAR(10),
                IN p_contact1 VARCHAR(50),
                IN p_contact2_code VARCHAR(10),
                IN p_contact2 VARCHAR(50),
                IN p_email VARCHAR(255),
                IN p_citizenship_country VARCHAR(255),
                IN p_passport_country VARCHAR(255),
                IN p_has_second_passport TINYINT(1),
                IN p_second_passport_country VARCHAR(255),
                IN p_highest_education VARCHAR(255),
                IN p_education_field VARCHAR(255),
                IN p_spouse_age INT,
                IN p_spouse_has_language_test TINYINT(1),
                IN p_c1_whatsapp TINYINT(1), IN p_c1_bot TINYINT(1), IN p_c1_telegram TINYINT(1),
                IN p_c2_whatsapp TINYINT(1), IN p_c2_bot TINYINT(1), IN p_c2_telegram TINYINT(1),
                IN p_has_skill_assessment TINYINT(1),
                IN p_skill_assessment_interest TINYINT(1),
                IN p_has_language_interest TINYINT(1),
                IN p_has_admission_interest TINYINT(1)
            )
            BEGIN
                INSERT INTO student_applications (
                    student_id, passport_name, age, dob, gender, marital_status, spouse_accompanying,
                    address_country, address_state, address_suburb, contact1_code, contact1,
                    contact2_code, contact2, email, citizenship_country, passport_country,
                    has_second_passport, second_passport_country, highest_education, education_field,
                    spouse_age, spouse_has_language_test, contact1_whatsapp, contact1_bot, contact1_telegram,
                    contact2_whatsapp, contact2_bot, contact2_telegram,
                    has_skill_assessment, skill_assessment_interest,
                    has_language_interest, has_admission_interest
                )
                VALUES (
                    p_student_id, p_passport_name, p_age, p_dob, p_gender, p_marital_status, p_spouse_accompanying,
                    p_address_country, p_address_state, p_address_suburb, p_contact1_code, p_contact1,
                    p_contact2_code, p_contact2, p_email, p_citizenship_country, p_passport_country,
                    p_has_second_passport, p_second_passport_country, p_highest_education, p_education_field,
                    p_spouse_age, p_spouse_has_language_test, p_c1_whatsapp, p_c1_bot, p_c1_telegram,
                    p_c2_whatsapp, p_c2_bot, p_c2_telegram,
                    p_has_skill_assessment, p_skill_assessment_interest,
                    p_has_language_interest, p_has_admission_interest
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
                    contact1_code = VALUES(contact1_code),
                    contact1 = VALUES(contact1),
                    contact1_whatsapp = VALUES(contact1_whatsapp),
                    contact1_bot = VALUES(contact1_bot),
                    contact1_telegram = VALUES(contact1_telegram),
                    contact2_code = VALUES(contact2_code),
                    contact2 = VALUES(contact2),
                    contact2_whatsapp = VALUES(contact2_whatsapp),
                    contact2_bot = VALUES(contact2_bot),
                    contact2_telegram = VALUES(contact2_telegram),
                    email = VALUES(email),
                    citizenship_country = VALUES(citizenship_country),
                    passport_country = VALUES(passport_country),
                    has_second_passport = VALUES(has_second_passport),
                    second_passport_country = VALUES(second_passport_country),
                    highest_education = VALUES(highest_education),
                    education_field = VALUES(education_field),
                    spouse_age = VALUES(spouse_age),
                    spouse_has_language_test = VALUES(spouse_has_language_test),
                    has_skill_assessment = VALUES(has_skill_assessment),
                    skill_assessment_interest = VALUES(skill_assessment_interest),
                    has_language_interest = VALUES(has_language_interest),
                    has_admission_interest = VALUES(has_admission_interest),
                    updated_at = CURRENT_TIMESTAMP;
                
                SELECT application_id AS app_id FROM student_applications WHERE student_id = p_student_id ORDER BY created_at DESC LIMIT 1;
            END
        `);
        console.log('✅ Updated sp_UpsertStudentApplication_Core successfully.');

        console.log('\n3. Updating Stored Procedure sp_UpsertStudentRegistration_Core...');
        await connection.query('DROP PROCEDURE IF EXISTS sp_UpsertStudentRegistration_Core');
        await connection.query(`
            CREATE PROCEDURE sp_UpsertStudentRegistration_Core(
                IN p_student_id INT,
                IN p_passport_name VARCHAR(255),
                IN p_first_name VARCHAR(255),
                IN p_last_name VARCHAR(255),
                IN p_age INT,
                IN p_dob DATE,
                IN p_gender VARCHAR(50),
                IN p_marital_status VARCHAR(50),
                IN p_spouse_accompanying TINYINT(1),
                IN p_address_country VARCHAR(255),
                IN p_address_state VARCHAR(255),
                IN p_address_suburb VARCHAR(255),
                IN p_address_postcode VARCHAR(20),
                IN p_contact1_code VARCHAR(10),
                IN p_contact1 VARCHAR(50),
                IN p_contact2_code VARCHAR(10),
                IN p_contact2 VARCHAR(50),
                IN p_email VARCHAR(255),
                IN p_citizenship_country VARCHAR(255),
                IN p_passport_country VARCHAR(255),
                IN p_has_second_passport TINYINT(1),
                IN p_second_passport_country VARCHAR(255),
                IN p_highest_education VARCHAR(255),
                IN p_education_field VARCHAR(255),
                IN p_spouse_age INT,
                IN p_spouse_has_language_test TINYINT(1),
                IN p_c1_whatsapp TINYINT(1), IN p_c1_bot TINYINT(1), IN p_c1_telegram TINYINT(1),
                IN p_c2_whatsapp TINYINT(1), IN p_c2_bot TINYINT(1), IN p_c2_telegram TINYINT(1),
                IN p_has_skill_assessment TINYINT(1),
                IN p_skill_assessment_interest TINYINT(1),
                IN p_has_language_interest TINYINT(1),
                IN p_has_admission_interest TINYINT(1)
            )
            BEGIN
                INSERT INTO student_registrations (
                    student_id, passport_name, first_name, last_name, age, dob, gender, marital_status, spouse_accompanying,
                    address_country, address_state, address_suburb, address_postcode, contact1_code, contact1,
                    contact2_code, contact2, email, citizenship_country, passport_country,
                    has_second_passport, second_passport_country, highest_education, education_field,
                    spouse_age, spouse_has_language_test, contact1_whatsapp, contact1_bot, contact1_telegram,
                    contact2_whatsapp, contact2_bot, contact2_telegram,
                    has_skill_assessment, skill_assessment_interest,
                    has_language_interest, has_admission_interest
                )
                VALUES (
                    p_student_id, p_passport_name, p_first_name, p_last_name, p_age, p_dob, p_gender, p_marital_status, p_spouse_accompanying,
                    p_address_country, p_address_state, p_address_suburb, p_address_postcode, p_contact1_code, p_contact1,
                    p_contact2_code, p_contact2, p_email, p_citizenship_country, p_passport_country,
                    p_has_second_passport, p_second_passport_country, p_highest_education, p_education_field,
                    p_spouse_age, p_spouse_has_language_test, p_c1_whatsapp, p_c1_bot, p_c1_telegram,
                    p_c2_whatsapp, p_c2_bot, p_c2_telegram,
                    p_has_skill_assessment, p_skill_assessment_interest,
                    p_has_language_interest, p_has_admission_interest
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
                    contact1_code = VALUES(contact1_code),
                    contact1 = VALUES(contact1),
                    contact1_whatsapp = VALUES(contact1_whatsapp),
                    contact1_bot = VALUES(contact1_bot),
                    contact1_telegram = VALUES(contact1_telegram),
                    contact2_code = VALUES(contact2_code),
                    contact2 = VALUES(contact2),
                    contact2_whatsapp = VALUES(contact2_whatsapp),
                    contact2_bot = VALUES(contact2_bot),
                    contact2_telegram = VALUES(contact2_telegram),
                    email = VALUES(email),
                    citizenship_country = VALUES(citizenship_country),
                    passport_country = VALUES(passport_country),
                    has_second_passport = VALUES(has_second_passport),
                    second_passport_country = VALUES(second_passport_country),
                    highest_education = VALUES(highest_education),
                    education_field = VALUES(education_field),
                    spouse_age = VALUES(spouse_age),
                    spouse_has_language_test = VALUES(spouse_has_language_test),
                    has_skill_assessment = VALUES(has_skill_assessment),
                    skill_assessment_interest = VALUES(skill_assessment_interest),
                    has_language_interest = VALUES(has_language_interest),
                    has_admission_interest = VALUES(has_admission_interest),
                    updated_at = CURRENT_TIMESTAMP;
                
                SELECT registration_id AS reg_id FROM student_registrations WHERE student_id = p_student_id ORDER BY created_at DESC LIMIT 1;
            END
        `);
        console.log('✅ Updated sp_UpsertStudentRegistration_Core successfully.');

        console.log('\nMigration Completed Successfully!');
    } catch (err) {
        console.error('❌ Migration Failed:', err);
    }
    process.exit(0);
}

main();
