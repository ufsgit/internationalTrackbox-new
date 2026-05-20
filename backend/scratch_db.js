const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '.env') });

const db = require('./db');

db.query(`
  CREATE TABLE IF NOT EXISTS other_types (
    other_type_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
`, (err, results) => {
  if (err) {
    console.error('Error creating table:', err);
  } else {
    console.log('Table other_types checked/created successfully!');
  }
  process.exit();
});
