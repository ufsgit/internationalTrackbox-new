require('dotenv').config({ path: '../.env' });
const db = require('../db');

const createMissingProcedures = async () => {
  const sp_AddApplicationLangTest = `
    CREATE PROCEDURE sp_AddApplicationLangTest(
      IN p_application_id INT,
      IN p_test_type VARCHAR(50),
      IN p_reading_score VARCHAR(10),
      IN p_writing_score VARCHAR(10),
      IN p_speaking_score VARCHAR(10),
      IN p_listening_score VARCHAR(10),
      IN p_overall_score VARCHAR(10),
      IN p_is_spouse TINYINT(1)
    )
    BEGIN
      INSERT INTO application_language_tests (
        application_id, test_type, reading_score, writing_score, speaking_score, listening_score, is_spouse
      ) VALUES (
        p_application_id, p_test_type, p_reading_score, p_writing_score, p_speaking_score, p_listening_score, p_is_spouse
      );
    END;
  `;

  const sp_AddApplicationAdmTest = `
    CREATE PROCEDURE sp_AddApplicationAdmTest(
      IN p_application_id INT,
      IN p_test_type VARCHAR(50),
      IN p_quant_score VARCHAR(10),
      IN p_verbal_score VARCHAR(10),
      IN p_data_insights_score VARCHAR(10),
      IN p_overall_score VARCHAR(10)
    )
    BEGIN
      INSERT INTO application_admission_tests (
        application_id, test_type, quant_score, verbal_score, data_insights_score
      ) VALUES (
        p_application_id, p_test_type, p_quant_score, p_verbal_score, p_data_insights_score
      );
    END;
  `;

  try {
    const promisePool = db.promise();
    
    console.log('Dropping existing procedures if they exist...');
    await promisePool.query("DROP PROCEDURE IF EXISTS sp_AddApplicationLangTest");
    await promisePool.query("DROP PROCEDURE IF EXISTS sp_AddApplicationAdmTest");

    console.log('Creating sp_AddApplicationLangTest...');
    await promisePool.query(sp_AddApplicationLangTest);
    console.log('sp_AddApplicationLangTest created successfully.');

    console.log('Creating sp_AddApplicationAdmTest...');
    await promisePool.query(sp_AddApplicationAdmTest);
    console.log('sp_AddApplicationAdmTest created successfully.');

    process.exit(0);
  } catch (error) {
    console.error('Error creating procedures:', error);
    process.exit(1);
  }
};

createMissingProcedures();
