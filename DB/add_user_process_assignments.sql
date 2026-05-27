-- ============================================================
-- User Process Assignments Table
-- Run this once on your database to enable the feature
-- ============================================================

CREATE TABLE IF NOT EXISTS user_process_assignments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  process_name VARCHAR(100) NOT NULL,
  country_id INT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Index for fast lookup by user
CREATE INDEX idx_upa_user_id ON user_process_assignments(user_id);
