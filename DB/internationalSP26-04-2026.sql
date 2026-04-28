DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AddFollowUp`(
    IN p_student_id INT,
    IN p_branch_id INT,
    IN p_dept_id INT,
    IN p_status VARCHAR(50),
    IN p_assigned_to INT,
    IN p_follow_up_date DATE,
    IN p_remark TEXT,
    IN p_created_by INT
)
BEGIN
    INSERT INTO follow_ups (
        student_id, branch_id, department_id, status, 
        assigned_to, follow_up_date, remark, created_by
    ) VALUES (
        p_student_id, p_branch_id, p_dept_id, p_status,
        p_assigned_to, p_follow_up_date, p_remark, p_created_by
    );
    
    -- Update Current Status and Last Remark in Student Table
    UPDATE students SET 
        current_status = p_status,
        last_remark = p_remark,
        assigned_to = p_assigned_to
    WHERE student_id = p_student_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_CreateStudent`(
    IN p_student_name VARCHAR(100),
    IN p_mobile_country_code VARCHAR(10),
    IN p_mobile_number VARCHAR(20),
    IN p_phone_country_code VARCHAR(10),
    IN p_phone_number VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_whatsapp BOOLEAN,
    IN p_botim BOOLEAN,
    IN p_telegram BOOLEAN,
    IN p_enquiry_source VARCHAR(100),
    IN p_study_interested BOOLEAN,
    IN p_migration_interested BOOLEAN,
    IN p_coaching_interested BOOLEAN,
    IN p_visa_interested BOOLEAN,
    IN p_work_interested BOOLEAN,
    IN p_branch_id INT,
    IN p_created_by INT
)
BEGIN
    INSERT INTO students (
        student_name, mobile_country_code, mobile_number, 
        phone_country_code, phone_number, email, 
        whatsapp, botim, telegram, enquiry_source,
        study_interested, migration_interested, coaching_interested, 
        visa_interested, work_interested, branch_id, created_by
    ) VALUES (
        p_student_name, p_mobile_country_code, p_mobile_number, 
        p_phone_country_code, p_phone_number, p_email, 
        p_whatsapp, p_botim, p_telegram, p_enquiry_source,
        p_study_interested, p_migration_interested, p_coaching_interested, 
        p_visa_interested, p_work_interested, p_branch_id, p_created_by
    );
    SELECT LAST_INSERT_ID() as student_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_DeleteStudent`(IN p_student_id INT)
BEGIN
    DELETE FROM students WHERE student_id = p_student_id;
    SELECT ROW_COUNT() as affected_rows;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetBranchDepartments`(IN p_branch_id INT)
BEGIN
    SELECT d.* 
    FROM departments d
    JOIN branch_departments bd ON d.department_id = bd.department_id
    WHERE bd.branch_id = p_branch_id
    ORDER BY d.department_name;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetBranchStatuses`(IN p_branch_id INT, IN p_dept_id INT)
BEGIN
    -- Check if Dept is in Branch, then return Dept Statuses
    IF EXISTS (SELECT 1 FROM branch_departments WHERE branch_id = p_branch_id AND department_id = p_dept_id) THEN
        CALL sp_GetDepartmentStatuses(p_dept_id);
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetDashboardStats`(
    IN p_filter VARCHAR(20),       -- 'day', 'month', 'all'
    IN p_startDate DATE,
    IN p_endDate DATE,
    IN p_userId INT,
    IN p_branchId INT,
    IN p_userRole VARCHAR(20)
)
BEGIN
    -- 1. Summary Counts
    SELECT 
        (SELECT COUNT(*) FROM students 
         WHERE (p_startDate IS NULL OR DATE(created_at) >= p_startDate)
           AND (p_endDate IS NULL OR DATE(created_at) <= p_endDate)
        ) as totalStudents,
        (SELECT COUNT(*) FROM follow_ups 
         WHERE follow_up_date = CURDATE()
        ) as todayFollowups,
        (SELECT COUNT(*) FROM follow_ups 
         WHERE follow_up_date < CURDATE()
           AND status NOT IN ('Visa Granted', 'Visa Rejected', 'Not Interested', 'Applied', 'Dead enquiry')
        ) as pendingFollowups;

    -- 2. Status Distribution
    SELECT current_status, COUNT(*) as count 
    FROM students 
    WHERE (p_startDate IS NULL OR DATE(created_at) >= p_startDate)
      AND (p_endDate IS NULL OR DATE(created_at) <= p_endDate)
    GROUP BY current_status;

    -- 3. Graph Data
    IF p_filter = 'day' THEN
        SELECT DATE_FORMAT(created_at, '%Y-%m-%d') as label, COUNT(*) as count 
        FROM students 
        WHERE (p_startDate IS NULL OR DATE(created_at) >= p_startDate)
          AND (p_endDate IS NULL OR DATE(created_at) <= p_endDate)
        GROUP BY DATE(created_at)
        ORDER BY DATE(created_at);
    ELSE
        -- Default to Month
        SELECT DATE_FORMAT(created_at, '%b %Y') as label, COUNT(*) as count 
        FROM students 
        WHERE (p_startDate IS NULL OR DATE(created_at) >= p_startDate)
          AND (p_endDate IS NULL OR DATE(created_at) <= p_endDate)
        GROUP BY YEAR(created_at), MONTH(created_at), label
        ORDER BY YEAR(created_at), MONTH(created_at);
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetDepartmentStatuses`(IN p_dept_id INT)
BEGIN
    SELECT s.* 
    FROM statuses s
    JOIN department_status_mappings dsm ON s.status_id = dsm.status_id
    WHERE dsm.department_id = p_dept_id
    ORDER BY s.status_name;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetEnquiryReport`(
    IN p_from_date DATE,
    IN p_to_date DATE,
    IN p_search VARCHAR(100),
    IN p_branch_id INT,
    IN p_staff_id INT
)
BEGIN
    -- Common CTE or just multiple SELECTs UNIONed 
    -- We select fields to match the report columns:
    -- Date, Student, Mobile, Type, Country, Program/Details, Intake/Batch, Status, Remark, AssignedTo, AssignedBy, Department

    SELECT * FROM (
        -- 1. Study
        SELECT 
            DATE(s.created_at) as created_date,
            s.student_name,
            CONCAT(s.mobile_country_code, ' ', s.mobile_number) as mobile,
            'Study' as enquiry_type,
            ss.country as country_or_course,
            CONCAT(IFNULL(ss.level,''), ' ', IFNULL(ss.field,'')) as program_details,
            CONCAT(IFNULL(ss.intake,''), ' ', IFNULL(ss.year,'')) as intake_or_batch,
            s.current_status,
            s.last_remark,
            u_to.username as assigned_to,
            u_by.username as created_by,
           
            b.branch_id,
            s.assigned_to as assigned_to_id
        FROM students s
        JOIN student_study_programs ss ON s.student_id = ss.student_id
        LEFT JOIN users u_to ON s.assigned_to = u_to.user_id
        LEFT JOIN users u_by ON s.created_by = u_by.user_id
        
        LEFT JOIN branches b ON s.branch_id = b.branch_id

        UNION ALL

        -- 2. Migration
        SELECT 
            DATE(s.created_at),
            s.student_name,
            CONCAT(s.mobile_country_code, ' ', s.mobile_number),
            'Migration',
            sm.country,
            sm.category as program_details, -- e.g. Express Entry
            '' as intake_or_batch,
            s.current_status,
            s.last_remark,
            u_to.username,
            u_by.username,
         
            b.branch_id,
            s.assigned_to as assigned_to_id
        FROM students s
        JOIN student_migration sm ON s.student_id = sm.student_id
        LEFT JOIN users u_to ON s.assigned_to = u_to.user_id
        LEFT JOIN users u_by ON s.created_by = u_by.user_id
     
        LEFT JOIN branches b ON s.branch_id = b.branch_id

        UNION ALL

        -- 3. Visa
        SELECT 
            DATE(s.created_at),
            s.student_name,
            CONCAT(s.mobile_country_code, ' ', s.mobile_number),
            'Visa',
            sv.country,
            sv.category,
            '' as intake_or_batch,
            s.current_status,
            s.last_remark,
            u_to.username,
            u_by.username,
           
            b.branch_id,
            s.assigned_to as assigned_to_id
        FROM students s
        JOIN student_visa sv ON s.student_id = sv.student_id
        LEFT JOIN users u_to ON s.assigned_to = u_to.user_id
        LEFT JOIN users u_by ON s.created_by = u_by.user_id
   
        LEFT JOIN branches b ON s.branch_id = b.branch_id

        UNION ALL

        -- 4. Work
        SELECT 
            DATE(s.created_at),
            s.student_name,
            CONCAT(s.mobile_country_code, ' ', s.mobile_number),
            'Work',
            sw.country,
            sw.occupation,
            '' as intake_or_batch,
            s.current_status,
            s.last_remark,
            u_to.username,
            u_by.username,
            
            b.branch_id,
            s.assigned_to as assigned_to_id
        FROM students s
        JOIN student_work sw ON s.student_id = sw.student_id
        LEFT JOIN users u_to ON s.assigned_to = u_to.user_id
        LEFT JOIN users u_by ON s.created_by = u_by.user_id
        
        LEFT JOIN branches b ON s.branch_id = b.branch_id
        
        UNION ALL

        -- 5. Coaching
        SELECT 
            DATE(s.created_at),
            s.student_name,
            CONCAT(s.mobile_country_code, ' ', s.mobile_number),
            'Coaching',
            sc.course, -- e.g. IELTS
            '' as program_details,
            sc.batch as intake_or_batch,
            s.current_status,
            s.last_remark,
            u_to.username,
            u_by.username,
           
            b.branch_id,
            s.assigned_to as assigned_to_id
        FROM students s
        JOIN student_coaching sc ON s.student_id = sc.student_id
        LEFT JOIN users u_to ON s.assigned_to = u_to.user_id
        LEFT JOIN users u_by ON s.created_by = u_by.user_id
  
        LEFT JOIN branches b ON s.branch_id = b.branch_id

    ) AS combined_report
    WHERE 
        (p_from_date IS NULL OR created_date >= p_from_date) AND
        (p_to_date IS NULL OR created_date <= p_to_date) AND
        (p_branch_id IS NULL OR branch_id = p_branch_id) AND
        (p_staff_id IS NULL OR assigned_to_id = p_staff_id) AND
        (p_search IS NULL OR student_name LIKE CONCAT('%', p_search, '%') OR mobile LIKE CONCAT('%', p_search, '%'))
    ORDER BY created_date DESC, student_name;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetEnquirySources`()
BEGIN
    SELECT * FROM enquiry_sources ORDER BY source_name;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetMasterLookups`()
BEGIN
    -- 0: Countries
    SELECT * FROM countries ORDER BY name;
    
    -- 1: Levels
    SELECT * FROM educational_levels ORDER BY name;
    
    -- 2: Intakes
    SELECT * FROM study_intakes ORDER BY name;
    
    -- 3: Occupations (Used in Work and Migration)
    SELECT * FROM occupations ORDER BY name;
    
    -- 4: Fields (Used in Study and Coaching)
    SELECT * FROM study_fields ORDER BY name;
    
    -- 5: Categories (Used primarily for Migration categories)
    SELECT * FROM migration_categories ORDER BY name;
    
    -- 6: Years (Static list)
    SELECT '2024' as name UNION SELECT '2025' UNION SELECT '2026' UNION SELECT '2027' UNION SELECT '2028' UNION SELECT '2029' UNION SELECT '2030';
    
    -- 7: Enquiry Sources
    SELECT * FROM enquiry_sources ORDER BY source_name;
    
    -- 8: Visa Categories
    SELECT * FROM visa_categories ORDER BY name;
    
    -- 9: Work Categories
    SELECT * FROM work_categories ORDER BY name;
    
    -- 10: Coaching Courses
    SELECT * FROM coaching_courses ORDER BY name;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetStatuses`()
BEGIN
    SELECT * FROM statuses ORDER BY status_name;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetStudentApplication`(IN p_student_id INT)
BEGIN
    -- 1. Get Application
    SELECT * FROM student_applications WHERE student_id = p_student_id;
    
    -- 2. Get Children
    SELECT * FROM application_children WHERE application_id = (SELECT application_id FROM student_applications WHERE student_id = p_student_id);
    
    -- 3. Get Suggested Programs
    SELECT * FROM suggested_programs WHERE application_id = (SELECT application_id FROM student_applications WHERE student_id = p_student_id);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetStudentList`(
    IN p_logged_user_id INT,
    IN p_dept_id INT,
    IN p_assigned_to INT,
    IN p_from_date DATE,
    IN p_to_date DATE,
    IN p_status VARCHAR(50),
    IN p_use_date BOOLEAN,
    IN p_search VARCHAR(100),
    IN p_limit INT,
    IN p_offset INT
)
BEGIN
    DECLARE v_branch_id INT;
    DECLARE v_role VARCHAR(50);
    
    SELECT branch_id, role INTO v_branch_id, v_role FROM users WHERE user_id = p_logged_user_id;

    -- Return total count first
    SELECT COUNT(*) as total
    FROM students s
    LEFT JOIN users at ON s.assigned_to = at.user_id
    WHERE (v_role = 'admin' OR s.branch_id = v_branch_id)
      AND (p_dept_id = 0 OR at.department_id = p_dept_id)
      AND (p_assigned_to = 0 OR s.assigned_to = p_assigned_to)
      AND (p_status = '' OR s.current_status = p_status)
      AND (p_search = '' OR s.student_name LIKE CONCAT('%', p_search, '%') OR s.mobile_number LIKE CONCAT('%', p_search, '%'))
      AND (p_use_date = FALSE OR 
          EXISTS (SELECT 1 FROM follow_ups WHERE student_id = s.student_id AND follow_up_date BETWEEN p_from_date AND p_to_date));

    -- Return records
    SELECT 
        s.student_id,
        s.is_registered,
        (SELECT MAX(created_at) FROM follow_ups WHERE student_id = s.student_id) as follow_up_entry_on,
        (SELECT MAX(follow_up_date) FROM follow_ups WHERE student_id = s.student_id) as follow_up_on,
        s.student_name,
        s.mobile_number,
        s.enquiry_source,
        s.last_remark as remark,
        (SELECT u.username FROM follow_ups f JOIN users u ON f.created_by = u.user_id WHERE f.student_id = s.student_id ORDER BY f.created_at DESC LIMIT 1) as follow_up_by_name,
        d.department_name,
        s.current_status as status,
        at.username as assigned_to_name,
        cb.username as created_by_name,
        b.branch_name
    FROM students s
    LEFT JOIN branches b ON s.branch_id = b.branch_id
    LEFT JOIN users cb ON s.created_by = cb.user_id
    LEFT JOIN users at ON s.assigned_to = at.user_id
    LEFT JOIN departments d ON at.department_id = d.department_id
    WHERE (v_role = 'admin' OR s.branch_id = v_branch_id)
      AND (p_dept_id = 0 OR at.department_id = p_dept_id)
      AND (p_assigned_to = 0 OR s.assigned_to = p_assigned_to)
      AND (p_status = '' OR s.current_status = p_status)
      AND (p_search = '' OR s.student_name LIKE CONCAT('%', p_search, '%') OR s.mobile_number LIKE CONCAT('%', p_search, '%'))
      AND (p_use_date = FALSE OR 
          EXISTS (SELECT 1 FROM follow_ups WHERE student_id = s.student_id AND follow_up_date BETWEEN p_from_date AND p_to_date))
    ORDER BY s.created_at DESC
    LIMIT p_limit OFFSET p_offset;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetStudentRegistration`(IN p_student_id INT)
BEGIN
    DECLARE v_reg_id INT DEFAULT NULL;
    SELECT registration_id INTO v_reg_id FROM student_registrations WHERE student_id = p_student_id LIMIT 1;
    IF v_reg_id IS NOT NULL THEN
        SELECT * FROM student_registrations WHERE student_id = p_student_id;
        SELECT * FROM registration_children WHERE registration_id = v_reg_id;
        SELECT * FROM registration_suggested_programs WHERE registration_id = v_reg_id;
    ELSE
        CALL sp_GetStudentApplication(p_student_id);
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetStudents`(
    IN p_user_role VARCHAR(20),
    IN p_branch_id INT
)
BEGIN
    IF p_user_role = 'admin' THEN
        SELECT s.*, b.branch_name, u.username as creator_name 
        FROM students s 
        LEFT JOIN branches b ON s.branch_id = b.branch_id 
        LEFT JOIN users u ON s.created_by = u.user_id;
    ELSE
        SELECT s.*, b.branch_name, u.username as creator_name 
        FROM students s 
        LEFT JOIN branches b ON s.branch_id = b.branch_id 
        LEFT JOIN users u ON s.created_by = u.user_id
        WHERE s.branch_id = p_branch_id;
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetUserById`(IN p_user_id INT)
BEGIN
    SELECT * FROM users WHERE user_id = p_user_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetUserPermissions`(IN p_user_id INT)
BEGIN
    -- Result 1: Branch/Dept Permissions
    SELECT * FROM user_permissions_docs WHERE user_id = p_user_id;
    -- Result 2: Page Permissions
    SELECT * FROM user_permissions_pages WHERE user_id = p_user_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetUsers`()
BEGIN
    SELECT 
        u.user_id, 
        u.username, 
        u.email, 
        u.mobile, 
        u.user_type, 
        u.status, 
        u.user_role,
        u.role,
        b.branch_name, 
        d.department_name
    FROM users u
    LEFT JOIN branches b ON u.branch_id = b.branch_id
    LEFT JOIN departments d ON u.department_id = d.department_id
    ORDER BY u.created_at DESC;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Login`(
    IN p_username VARCHAR(50)
)
BEGIN
    SELECT user_id, username, password, branch_id, department_id, user_type 
    FROM users 
    WHERE username = p_username;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UpdateBranchDepartments`(IN p_branch_id INT, IN p_dept_ids JSON)
BEGIN
    -- Remove existing mappings
    DELETE FROM branch_departments WHERE branch_id = p_branch_id;
    
    -- Insert new mappings from JSON array
    IF JSON_LENGTH(p_dept_ids) > 0 THEN
        INSERT INTO branch_departments (branch_id, department_id)
        SELECT p_branch_id, department_id 
        FROM departments 
        WHERE JSON_CONTAINS(p_dept_ids, CAST(department_id AS CHAR));
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UpdateDepartmentStatuses`(IN p_dept_id INT, IN p_status_ids JSON)
BEGIN
    -- Remove existing mappings
    DELETE FROM department_status_mappings WHERE department_id = p_dept_id;
    
    -- Insert new mappings
    IF JSON_LENGTH(p_status_ids) > 0 THEN
        INSERT INTO department_status_mappings (department_id, status_id)
        SELECT p_dept_id, status_id
        FROM statuses
        WHERE JSON_CONTAINS(p_status_ids, CAST(status_id AS CHAR));
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UpsertBranch`(IN p_id INT, IN p_name VARCHAR(100))
BEGIN
    IF p_id = 0 THEN
        INSERT INTO branches (branch_name) VALUES (p_name);
    ELSE
        UPDATE branches SET branch_name = p_name WHERE branch_id = p_id;
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UpsertDepartment`(IN p_id INT, IN p_name VARCHAR(100))
BEGIN
    IF p_id = 0 THEN
        INSERT INTO departments (department_name) VALUES (p_name);
    ELSE
        UPDATE departments SET department_name = p_name WHERE department_id = p_id;
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UpsertDepartmentStatus`(IN p_id INT, IN p_dept_id INT, IN p_name VARCHAR(50))
BEGIN
    IF p_id = 0 THEN
        INSERT INTO department_statuses (department_id, status_name) VALUES (p_dept_id, p_name);
    ELSE
        UPDATE department_statuses SET department_id = p_dept_id, status_name = p_name WHERE status_id = p_id;
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UpsertEnquirySource`(IN p_id INT, IN p_name VARCHAR(100))
BEGIN
    IF p_id = 0 THEN
        INSERT INTO enquiry_sources (source_name) VALUES (p_name);
    ELSE
        UPDATE enquiry_sources SET source_name = p_name WHERE source_id = p_id;
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UpsertStatus`(IN p_id INT, IN p_name VARCHAR(50), IN p_followup TINYINT(1))
BEGIN IF p_id = 0 THEN INSERT INTO statuses (status_name, requires_followup) VALUES (p_name, p_followup); ELSE UPDATE statuses SET status_name = p_name, requires_followup = p_followup WHERE status_id = p_id; END IF; END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UpsertStudent`(
    IN p_id INT,
    IN p_name VARCHAR(100),
    IN p_mobile_cc VARCHAR(10),
    IN p_mobile_num VARCHAR(20),
    IN p_phone_cc VARCHAR(10),
    IN p_phone_num VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_whatsapp BOOLEAN,
    IN p_botim BOOLEAN,
    IN p_telegram BOOLEAN,
    IN p_phone_whatsapp BOOLEAN,
    IN p_phone_botim BOOLEAN,
    IN p_phone_telegram BOOLEAN,
    IN p_source VARCHAR(100),
    IN p_study BOOLEAN,
    IN p_migration BOOLEAN,
    IN p_coaching BOOLEAN,
    IN p_visa BOOLEAN,
    IN p_work BOOLEAN,
    IN p_branch_id INT,
    IN p_created_by INT,
    IN p_assigned_to INT
)
BEGIN
    IF p_id = 0 THEN
        INSERT INTO students (
            student_name, mobile_country_code, mobile_number, 
            phone_country_code, phone_number, email, 
            whatsapp, botim, telegram, 
            phone_whatsapp, phone_botim, phone_telegram,
            enquiry_source,
            study_interested, migration_interested, coaching_interested,
            visa_interested, work_interested, branch_id, created_by, assigned_to
        ) VALUES (
            p_name, p_mobile_cc, p_mobile_num,
            p_phone_cc, p_phone_num, p_email,
            p_whatsapp, p_botim, p_telegram, 
            p_phone_whatsapp, p_phone_botim, p_phone_telegram,
            p_source,
            p_study, p_migration, p_coaching,
            p_visa, p_work, p_branch_id, p_created_by, p_assigned_to
        );
        SELECT LAST_INSERT_ID() AS student_id;
    ELSE
        UPDATE students SET 
            student_name = p_name,
            mobile_country_code = p_mobile_cc,
            mobile_number = p_mobile_num,
            phone_country_code = p_phone_cc,
            phone_number = p_phone_num,
            email = p_email,
            whatsapp = p_whatsapp,
            botim = p_botim,
            telegram = p_telegram,
            phone_whatsapp = p_phone_whatsapp,
            phone_botim = p_phone_botim,
            phone_telegram = p_phone_telegram,
            enquiry_source = p_source,
            study_interested = p_study,
            migration_interested = p_migration,
            coaching_interested = p_coaching,
            visa_interested = p_visa,
            work_interested = p_work,
            branch_id = p_branch_id,
            assigned_to = p_assigned_to
        WHERE student_id = p_id;
        SELECT p_id AS student_id;
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UpsertStudentApplication`(
    IN p_student_id INT,
    IN p_passport_name VARCHAR(255),
    IN p_age INT,
    IN p_dob DATE,
    IN p_gender ENUM('Male', 'Female', 'Other'),
    IN p_marital_status VARCHAR(50),
    IN p_spouse_accompanying TINYINT(1),
    IN p_address_country VARCHAR(100),
    IN p_address_state VARCHAR(100),
    IN p_address_suburb VARCHAR(100),
    IN p_mobile_country_code VARCHAR(10),
    IN p_contact1 VARCHAR(50),
    IN p_phone_country_code VARCHAR(10),
    IN p_contact2 VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_citizenship_country VARCHAR(100),
    IN p_passport_country VARCHAR(100),
    IN p_has_second_passport TINYINT(1),
    IN p_second_passport_country VARCHAR(100),
    IN p_highest_education VARCHAR(100),
    IN p_education_field VARCHAR(100),
    IN p_has_canadian_edu TINYINT(1),
    IN p_canadian_edu_level VARCHAR(100),
    IN p_canadian_edu_field VARCHAR(100),
    IN p_has_australian_edu TINYINT(1),
    IN p_australian_edu_level VARCHAR(100),
    IN p_australian_edu_field VARCHAR(100),
    IN p_has_aus_specialised_edu TINYINT(1),
    IN p_aus_specialised_edu_level VARCHAR(100),
    IN p_aus_specialised_edu_field VARCHAR(100),
    IN p_has_nz_edu TINYINT(1),
    IN p_nz_edu_level VARCHAR(100),
    IN p_nz_edu_field VARCHAR(100),
    IN p_has_work_experience TINYINT(1),
    IN p_total_work_experience VARCHAR(50),
    IN p_canadian_work_years VARCHAR(50),
    IN p_australian_work_years VARCHAR(50),
    IN p_nz_work_years VARCHAR(50),
    IN p_has_language_test TINYINT(1),
    IN p_language_test_type VARCHAR(50),
    IN p_writing_score VARCHAR(20),
    IN p_listening_score VARCHAR(20),
    IN p_speaking_score VARCHAR(20),
    IN p_reading_score VARCHAR(20),
    IN p_has_admission_test TINYINT(1),
    IN p_admission_test_type VARCHAR(50),
    IN p_quant_score VARCHAR(20),
    IN p_verbal_score VARCHAR(20),
    IN p_data_insights_score VARCHAR(20),
    IN p_spouse_age INT,
    IN p_spouse_edu_level VARCHAR(100),
    IN p_spouse_canadian_edu TINYINT(1),
    IN p_spouse_canadian_edu_level VARCHAR(100),
    IN p_spouse_canadian_edu_field VARCHAR(100),
    IN p_spouse_australian_edu TINYINT(1),
    IN p_spouse_australian_edu_level VARCHAR(100),
    IN p_spouse_australian_edu_field VARCHAR(100),
    IN p_spouse_aus_specialised_edu TINYINT(1),
    IN p_spouse_aus_specialised_edu_level VARCHAR(100),
    IN p_spouse_aus_specialised_edu_field VARCHAR(100),
    IN p_spouse_work_exp VARCHAR(50),
    IN p_spouse_canadian_work VARCHAR(50),
    IN p_spouse_australian_work VARCHAR(50),
    IN p_spouse_nz_work VARCHAR(50),
    IN p_spouse_lang_test_type VARCHAR(50),
    IN p_spouse_writing VARCHAR(20),
    IN p_spouse_listening VARCHAR(20),
    IN p_spouse_speaking VARCHAR(20),
    IN p_spouse_reading VARCHAR(20),
    IN p_has_relatives TINYINT(1),
    IN p_relative_relationship VARCHAR(100),
    IN p_relative_related_to VARCHAR(50),
    IN p_education_data JSON,
    IN p_migration_data JSON,
    IN p_migration_spouse_data JSON,
    IN p_relatives_data JSON
)
BEGIN
    DECLARE v_app_id INT;
    
    -- Check if application exists for the student
    SELECT application_id INTO v_app_id FROM student_applications WHERE student_id = p_student_id LIMIT 1;
    
    IF v_app_id IS NULL THEN
        INSERT INTO student_applications (
            student_id, passport_name, age, dob, gender, marital_status,
            spouse_accompanying, address_country, address_state, address_suburb,
            mobile_country_code, contact1, phone_country_code, contact2, email, citizenship_country, passport_country,
            has_second_passport, second_passport_country,
            highest_education, education_field, has_canadian_edu,
            canadian_edu_level, canadian_edu_field, has_australian_edu,
            australian_edu_level, australian_edu_field, has_aus_specialised_edu,
            aus_specialised_edu_level, aus_specialised_edu_field, has_nz_edu,
            nz_edu_level, nz_edu_field, has_work_experience, total_work_experience,
            canadian_work_years, australian_work_years, nz_work_years,
            has_language_test, language_test_type, writing_score, listening_score,
            speaking_score, reading_score, has_admission_test, admission_test_type,
            quant_score, verbal_score, data_insights_score, spouse_age,
            spouse_edu_level, spouse_canadian_edu, spouse_canadian_edu_level,
            spouse_canadian_edu_field, spouse_australian_edu, spouse_australian_edu_level,
            spouse_australian_edu_field, spouse_aus_specialised_edu,
            spouse_aus_specialised_edu_level, spouse_aus_specialised_edu_field,
            spouse_work_exp, spouse_canadian_work, spouse_australian_work,
            spouse_nz_work, spouse_lang_test_type, spouse_writing, spouse_listening,
            spouse_speaking, spouse_reading, has_relatives, relative_relationship,
            relative_related_to, education_data, migration_data,
            migration_spouse_data, relatives_data
        ) VALUES (
            p_student_id, p_passport_name, p_age, p_dob, p_gender, p_marital_status,
            p_spouse_accompanying, p_address_country, p_address_state, p_address_suburb,
            p_mobile_country_code, p_contact1, p_phone_country_code, p_contact2, p_email, p_citizenship_country, p_passport_country,
            p_has_second_passport, p_second_passport_country,
            p_highest_education, p_education_field, p_has_canadian_edu,
            p_canadian_edu_level, p_canadian_edu_field, p_has_australian_edu,
            p_australian_edu_level, p_australian_edu_field, p_has_aus_specialised_edu,
            p_aus_specialised_edu_level, p_aus_specialised_edu_field, p_has_nz_edu,
            p_nz_edu_level, p_nz_edu_field, p_has_work_experience, p_total_work_experience,
            p_canadian_work_years, p_australian_work_years, p_nz_work_years,
            p_has_language_test, p_language_test_type, p_writing_score, p_listening_score,
            p_speaking_score, p_reading_score, p_has_admission_test, p_admission_test_type,
            p_quant_score, p_verbal_score, p_data_insights_score, p_spouse_age,
            p_spouse_edu_level, p_spouse_canadian_edu, p_spouse_canadian_edu_level,
            p_spouse_canadian_edu_field, p_spouse_australian_edu, p_spouse_australian_edu_level,
            p_spouse_australian_edu_field, p_spouse_aus_specialised_edu,
            p_spouse_aus_specialised_edu_level, p_spouse_aus_specialised_edu_field,
            p_spouse_work_exp, p_spouse_canadian_work, p_spouse_australian_work,
            p_spouse_nz_work, p_spouse_lang_test_type, p_spouse_writing, p_spouse_listening,
            p_spouse_speaking, p_spouse_reading, p_has_relatives, p_relative_relationship,
            p_relative_related_to, p_education_data, p_migration_data,
            p_migration_spouse_data, p_relatives_data
        );
        SET v_app_id = LAST_INSERT_ID();
    ELSE
        UPDATE student_applications SET
            passport_name = p_passport_name, age = p_age, dob = p_dob, gender = p_gender,
            marital_status = p_marital_status, spouse_accompanying = p_spouse_accompanying,
            address_country = p_address_country, address_state = p_address_state,
            address_suburb = p_address_suburb, mobile_country_code = p_mobile_country_code,
            contact1 = p_contact1, phone_country_code = p_phone_country_code,
            contact2 = p_contact2,
            email = p_email, citizenship_country = p_citizenship_country,
            passport_country = p_passport_country, has_second_passport = p_has_second_passport,
            second_passport_country = p_second_passport_country,
            highest_education = p_highest_education, education_field = p_education_field,
            has_canadian_edu = p_has_canadian_edu, canadian_edu_level = p_canadian_edu_level,
            canadian_edu_field = p_canadian_edu_field, has_australian_edu = p_has_australian_edu,
            australian_edu_level = p_australian_edu_level, australian_edu_field = p_australian_edu_field,
            has_aus_specialised_edu = p_has_aus_specialised_edu,
            aus_specialised_edu_level = p_aus_specialised_edu_level,
            aus_specialised_edu_field = p_aus_specialised_edu_field, has_nz_edu = p_has_nz_edu,
            nz_edu_level = p_nz_edu_level, nz_edu_field = p_nz_edu_field,
            has_work_experience = p_has_work_experience, total_work_experience = p_total_work_experience,
            canadian_work_years = p_canadian_work_years, australian_work_years = p_australian_work_years,
            nz_work_years = p_nz_work_years, has_language_test = p_has_language_test,
            language_test_type = p_language_test_type, writing_score = p_writing_score,
            listening_score = p_listening_score, speaking_score = p_speaking_score,
            reading_score = p_reading_score, has_admission_test = p_has_admission_test,
            admission_test_type = p_admission_test_type, quant_score = p_quant_score,
            verbal_score = p_verbal_score, data_insights_score = p_data_insights_score,
            spouse_age = p_spouse_age, spouse_edu_level = p_spouse_edu_level,
            spouse_canadian_edu = p_spouse_canadian_edu, spouse_canadian_edu_level = p_spouse_canadian_edu_level,
            spouse_canadian_edu_field = p_spouse_canadian_edu_field,
            spouse_australian_edu = p_spouse_australian_edu,
            spouse_australian_edu_level = p_spouse_australian_edu_level,
            spouse_australian_edu_field = p_spouse_australian_edu_field,
            spouse_aus_specialised_edu = p_spouse_aus_specialised_edu,
            spouse_aus_specialised_edu_level = p_spouse_aus_specialised_edu_level,
            spouse_aus_specialised_edu_field = p_spouse_aus_specialised_edu_field,
            spouse_work_exp = p_spouse_work_exp, spouse_canadian_work = p_spouse_canadian_work,
            spouse_australian_work = p_spouse_australian_work, spouse_nz_work = p_spouse_nz_work,
            spouse_lang_test_type = p_spouse_lang_test_type, spouse_writing = p_spouse_writing,
            spouse_listening = p_spouse_listening, spouse_speaking = p_spouse_speaking,
            spouse_reading = p_spouse_reading, has_relatives = p_has_relatives,
            relative_relationship = p_relative_relationship, relative_related_to = p_relative_related_to,
            education_data = p_education_data, migration_data = p_migration_data,
            migration_spouse_data = p_migration_spouse_data, relatives_data = p_relatives_data,
            updated_at = CURRENT_TIMESTAMP
        WHERE application_id = v_app_id;
    END IF;
    SELECT v_app_id AS application_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UpsertStudentRegistration`(
    IN p_student_id INT, IN p_passport_name VARCHAR(255), IN p_first_name VARCHAR(100), IN p_last_name VARCHAR(100), IN p_age INT, IN p_dob DATE, IN p_gender ENUM('Male', 'Female', 'Other'),
    IN p_marital_status VARCHAR(50), IN p_spouse_accompanying TINYINT(1), IN p_address_country VARCHAR(100),
    IN p_address_state VARCHAR(100), IN p_address_suburb VARCHAR(100), IN p_mobile_country_code VARCHAR(10), IN p_contact1 VARCHAR(50),
    IN p_phone_country_code VARCHAR(10), IN p_contact2 VARCHAR(50), IN p_email VARCHAR(100), IN p_citizenship_country VARCHAR(100),
    IN p_passport_country VARCHAR(100), IN p_has_second_passport TINYINT(1), IN p_second_passport_country VARCHAR(100),
    IN p_highest_education VARCHAR(100), IN p_education_field VARCHAR(100), IN p_has_canadian_edu TINYINT(1),
    IN p_canadian_edu_level VARCHAR(100), IN p_canadian_edu_field VARCHAR(100), IN p_has_australian_edu TINYINT(1),
    IN p_australian_edu_level VARCHAR(100), IN p_australian_edu_field VARCHAR(100), IN p_has_aus_specialised_edu TINYINT(1),
    IN p_aus_specialised_edu_level VARCHAR(100), IN p_aus_specialised_edu_field VARCHAR(100), IN p_has_nz_edu TINYINT(1),
    IN p_nz_edu_level VARCHAR(100), IN p_nz_edu_field VARCHAR(100), IN p_has_work_experience TINYINT(1),
    IN p_total_work_experience VARCHAR(50), IN p_canadian_work_years VARCHAR(50), IN p_australian_work_years VARCHAR(50),
    IN p_nz_work_years VARCHAR(50), IN p_has_language_test TINYINT(1), IN p_language_test_type VARCHAR(50),
    IN p_writing_score VARCHAR(20), IN p_listening_score VARCHAR(20), IN p_speaking_score VARCHAR(20),
    IN p_reading_score VARCHAR(20), IN p_has_admission_test TINYINT(1), IN p_admission_test_type VARCHAR(50),
    IN p_quant_score VARCHAR(20), IN p_verbal_score VARCHAR(20), IN p_data_insights_score VARCHAR(20),
    IN p_spouse_age INT, IN p_spouse_edu_level VARCHAR(100), IN p_spouse_canadian_edu TINYINT(1),
    IN p_spouse_canadian_edu_level VARCHAR(100), IN p_spouse_canadian_edu_field VARCHAR(100),
    IN p_spouse_australian_edu TINYINT(1), IN p_spouse_australian_edu_level VARCHAR(100),
    IN p_spouse_australian_edu_field VARCHAR(100), IN p_spouse_aus_specialised_edu TINYINT(1),
    IN p_spouse_aus_specialised_edu_level VARCHAR(100), IN p_spouse_aus_specialised_edu_field VARCHAR(100),
    IN p_spouse_work_exp VARCHAR(50), IN p_spouse_canadian_work VARCHAR(50), IN p_spouse_australian_work VARCHAR(50),
    IN p_spouse_nz_work VARCHAR(50), IN p_spouse_lang_test_type VARCHAR(50), IN p_spouse_writing VARCHAR(20),
    IN p_spouse_listening VARCHAR(20), IN p_spouse_speaking VARCHAR(20), IN p_spouse_reading VARCHAR(20),
    IN p_has_relatives TINYINT(1), IN p_relative_relationship VARCHAR(100), IN p_relative_related_to VARCHAR(50),
    IN p_education_data JSON, IN p_migration_data JSON, IN p_migration_spouse_data JSON, IN p_relatives_data JSON
)
BEGIN
    DECLARE v_reg_id INT;
    SELECT registration_id INTO v_reg_id FROM student_registrations WHERE student_id = p_student_id LIMIT 1;
    IF v_reg_id IS NULL THEN
        INSERT INTO student_registrations (
            student_id, passport_name, first_name, last_name, age, dob, gender, marital_status, spouse_accompanying, address_country, address_state, address_suburb,
            contact1_code, contact1, contact2_code, contact2, email, citizenship_country, passport_country, has_second_passport, second_passport_country,
            highest_education, education_field, has_canadian_edu, canadian_edu_level,
            canadian_edu_field, has_australian_edu, australian_edu_level, australian_edu_field, has_aus_specialised_edu, aus_specialised_edu_level,
            aus_specialised_edu_field, has_nz_edu, nz_edu_level, nz_edu_field, has_work_experience, total_work_experience, canadian_work_years,
            australian_work_years, nz_work_years, has_language_test, language_test_type, writing_score, listening_score, speaking_score,
            reading_score, has_admission_test, admission_test_type, quant_score, verbal_score, data_insights_score, spouse_age, spouse_edu_level,
            spouse_canadian_edu, spouse_canadian_edu_level, spouse_canadian_edu_field, spouse_australian_edu, spouse_australian_edu_level,
            spouse_australian_edu_field, spouse_aus_specialised_edu, spouse_aus_specialised_edu_level, spouse_aus_specialised_edu_field,
            spouse_work_exp, spouse_canadian_work, spouse_australian_work, spouse_nz_work, spouse_lang_test_type, spouse_writing, spouse_listening,
            spouse_speaking, spouse_reading, has_relatives, relative_relationship, relative_related_to, education_data, migration_data,
            migration_spouse_data, relatives_data
        ) VALUES (
            p_student_id, p_passport_name, p_first_name, p_last_name, p_age, p_dob, p_gender, p_marital_status, p_spouse_accompanying, p_address_country, p_address_state, p_address_suburb,
            p_mobile_country_code, p_contact1, p_phone_country_code, p_contact2, p_email, p_citizenship_country, p_passport_country, p_has_second_passport, p_second_passport_country,
            p_highest_education, p_education_field, p_has_canadian_edu, p_canadian_edu_level,
            p_canadian_edu_field, p_has_australian_edu, p_australian_edu_level, p_australian_edu_field, p_has_aus_specialised_edu, p_aus_specialised_edu_level,
            p_aus_specialised_edu_field, p_has_nz_edu, p_nz_edu_level, p_nz_edu_field, p_has_work_experience, p_total_work_experience, p_canadian_work_years,
            p_australian_work_years, p_nz_work_years, p_has_language_test, p_language_test_type, p_writing_score, p_listening_score, p_speaking_score,
            p_reading_score, p_has_admission_test, p_admission_test_type, p_quant_score, p_verbal_score, p_data_insights_score, p_spouse_age, p_spouse_edu_level,
            p_spouse_canadian_edu, p_spouse_canadian_edu_level, p_spouse_canadian_edu_field, p_spouse_australian_edu, p_spouse_australian_edu_level,
            p_spouse_australian_edu_field, p_spouse_aus_specialised_edu, p_spouse_aus_specialised_edu_level, p_spouse_aus_specialised_edu_field,
            p_spouse_work_exp, p_spouse_canadian_work, p_spouse_australian_work, p_spouse_nz_work, p_spouse_lang_test_type, p_spouse_writing, p_spouse_listening,
            p_spouse_speaking, p_spouse_reading, p_has_relatives, p_relative_relationship, p_relative_related_to, p_education_data, p_migration_data,
            p_migration_spouse_data, p_relatives_data
        );
        SET v_reg_id = LAST_INSERT_ID();
    ELSE
        UPDATE student_registrations SET
            passport_name = p_passport_name, first_name = p_first_name, last_name = p_last_name, age = p_age, dob = p_dob, gender = p_gender, marital_status = p_marital_status, spouse_accompanying = p_spouse_accompanying,
            address_country = p_address_country, address_state = p_address_state, address_suburb = p_address_suburb, 
            contact1_code = p_mobile_country_code, contact1 = p_contact1, 
            contact2_code = p_phone_country_code, contact2 = p_contact2,
            email = p_email, citizenship_country = p_citizenship_country, passport_country = p_passport_country, has_second_passport = p_has_second_passport,
            second_passport_country = p_second_passport_country, highest_education = p_highest_education, education_field = p_education_field,
            has_canadian_edu = p_has_canadian_edu, canadian_edu_level = p_canadian_edu_level, canadian_edu_field = p_canadian_edu_field,
            has_australian_edu = p_has_australian_edu, australian_edu_level = p_australian_edu_level, australian_edu_field = p_australian_edu_field,
            has_aus_specialised_edu = p_has_aus_specialised_edu, aus_specialised_edu_level = p_aus_specialised_edu_level,
            aus_specialised_edu_field = p_aus_specialised_edu_field, has_nz_edu = p_has_nz_edu, nz_edu_level = p_nz_edu_level, nz_edu_field = p_nz_edu_field,
            has_work_experience = p_has_work_experience, total_work_experience = p_total_work_experience, canadian_work_years = p_canadian_work_years,
            australian_work_years = p_australian_work_years, nz_work_years = p_nz_work_years, has_language_test = p_has_language_test,
            language_test_type = p_language_test_type, writing_score = p_writing_score, listening_score = p_listening_score, speaking_score = p_speaking_score,
            reading_score = p_reading_score, has_admission_test = p_has_admission_test, admission_test_type = p_admission_test_type, quant_score = p_quant_score,
            verbal_score = p_verbal_score, data_insights_score = p_data_insights_score, spouse_age = p_spouse_age, spouse_edu_level = p_spouse_edu_level,
            spouse_canadian_edu = p_spouse_canadian_edu, spouse_canadian_edu_level = p_spouse_canadian_edu_level, spouse_canadian_edu_field = p_spouse_canadian_edu_field,
            spouse_australian_edu = p_spouse_australian_edu, spouse_australian_edu_level = p_spouse_australian_edu_level,
            spouse_australian_edu_field = p_spouse_australian_edu_field, spouse_aus_specialised_edu = p_spouse_aus_specialised_edu,
            spouse_aus_specialised_edu_level = p_spouse_aus_specialised_edu_level, spouse_aus_specialised_edu_field = p_spouse_aus_specialised_edu_field,
            spouse_work_exp = p_spouse_work_exp, spouse_canadian_work = p_spouse_canadian_work, spouse_australian_work = p_spouse_australian_work,
            spouse_nz_work = p_spouse_nz_work, spouse_lang_test_type = p_spouse_lang_test_type, spouse_writing = p_spouse_writing,
            spouse_listening = p_spouse_listening, spouse_speaking = p_spouse_speaking, spouse_reading = p_spouse_reading, has_relatives = p_has_relatives,
            relative_relationship = p_relative_relationship, relative_related_to = p_relative_related_to, education_data = p_education_data,
            migration_data = p_migration_data, migration_spouse_data = p_migration_spouse_data, relatives_data = p_relatives_data,
            updated_at = CURRENT_TIMESTAMP
        WHERE registration_id = v_reg_id;
    END IF;
    SELECT v_reg_id AS registration_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UpsertUser`(
    IN p_user_id INT,
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_email VARCHAR(100),
    IN p_mobile VARCHAR(20),
    IN p_user_type VARCHAR(50),
    IN p_status VARCHAR(50),
    IN p_branch_id INT,
    IN p_department_id INT,
    IN p_user_role VARCHAR(100),
    IN p_backup_user VARCHAR(100),
    IN p_extension VARCHAR(50),
    IN p_all_time_view BOOLEAN,
    IN p_role VARCHAR(50)
)
BEGIN
    IF p_user_id IS NULL OR p_user_id = 0 THEN
        INSERT INTO users (
            username, password, email, mobile, user_type, status, 
            branch_id, department_id, user_role, backup_user, 
            extension, all_time_view, role
        ) VALUES (
            p_username, p_password, p_email, p_mobile, p_user_type, p_status, 
            p_branch_id, p_department_id, p_user_role, p_backup_user, 
            p_extension, p_all_time_view, p_role
        );
        SELECT LAST_INSERT_ID() as user_id;
    ELSE
        UPDATE users SET
            username = p_username,
            password = IF(p_password IS NOT NULL AND p_password != '', p_password, password),
            email = p_email,
            mobile = p_mobile,
            user_type = p_user_type,
            status = p_status,
            branch_id = p_branch_id,
            department_id = p_department_id,
            user_role = p_user_role,
            backup_user = p_backup_user,
            extension = p_extension,
            all_time_view = p_all_time_view,
            role = p_role
        WHERE user_id = p_user_id;
        SELECT p_user_id as user_id;
    END IF;
END$$
DELIMITER ;
