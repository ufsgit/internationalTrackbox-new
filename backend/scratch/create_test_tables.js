require('dotenv').config({ path: '../.env' });
const db = require('../db');

const createTables = async () => {
  const languageTestsTable = `
    CREATE TABLE IF NOT EXISTS application_language_tests (
      id INT AUTO_INCREMENT PRIMARY KEY,
      application_id INT NOT NULL,
      test_type VARCHAR(50) DEFAULT NULL,
      writing_score VARCHAR(10) DEFAULT NULL,
      listening_score VARCHAR(10) DEFAULT NULL,
      speaking_score VARCHAR(10) DEFAULT NULL,
      reading_score VARCHAR(10) DEFAULT NULL,
      is_spouse TINYINT(1) DEFAULT 0,
      FOREIGN KEY (application_id) REFERENCES student_applications(application_id) ON DELETE CASCADE
    );
  `;

  const admissionTestsTable = `
    CREATE TABLE IF NOT EXISTS application_admission_tests (
      id INT AUTO_INCREMENT PRIMARY KEY,
      application_id INT NOT NULL,
      test_type VARCHAR(50) DEFAULT NULL,
      quant_score VARCHAR(10) DEFAULT NULL,
      verbal_score VARCHAR(10) DEFAULT NULL,
      data_insights_score VARCHAR(10) DEFAULT NULL,
      FOREIGN KEY (application_id) REFERENCES student_applications(application_id) ON DELETE CASCADE
    );
  `;

  try {
    const promisePool = db.promise();
    
    console.log('Creating application_language_tests table...');
    await promisePool.query(languageTestsTable);
    console.log('application_language_tests created successfully.');

    console.log('Creating application_admission_tests table...');
    await promisePool.query(admissionTestsTable);
    console.log('application_admission_tests created successfully.');

    process.exit(0);
  } catch (error) {
    console.error('Error creating tables:', error);
    process.exit(1);
  }
};

createTables();
