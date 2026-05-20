const db = require('../../config/db');

const toBoolInt = (val) => {
    if (val === true || val === 'true' || val === 1 || val === '1') return 1;
    return 0;
};

const normalizeDate = (d) => {
    if (!d) return null;
    if (typeof d === 'string') {
        if (d.includes('T')) return d.split('T')[0]; // Extract YYYY-MM-DD from ISO string
        if (d.length === 7 && d.includes('-')) {
            return `${d}-01`; // Convert YYYY-MM to YYYY-MM-01
        }
    }
    return d;
};

const getStudents = (filters, userId) => {
    const {
        deptId = 0,
        assignedTo = 0,
        fromDate = null,
        toDate = null,
        status = '',
        useDate = 'false',
        search = '',
        page = 1,
        limit = 20
    } = filters;

    const offset = (parseInt(page) - 1) * parseInt(limit);

    return new Promise((resolve, reject) => {
        db.query(
            'CALL sp_GetStudentList(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
            [
                userId,
                parseInt(deptId),
                parseInt(assignedTo),
                fromDate,
                toDate,
                status,
                useDate === 'true',
                search,
                parseInt(limit),
                offset
            ],
            function (err, results) {
                if (err) return reject(err);
                resolve({
                    total: results[0][0].total,
                    students: results[1]
                });
            }
        );
    });
};

const getStudentById = (studentId) => {
    return new Promise((resolve, reject) => {
        const queries = [
            'SELECT * FROM students WHERE student_id = ?',
            'SELECT * FROM student_study_programs WHERE student_id = ?',
            'SELECT * FROM student_migration WHERE student_id = ?',
            'SELECT * FROM student_coaching WHERE student_id = ?',
            'SELECT * FROM student_visa WHERE student_id = ?',
            'SELECT * FROM student_work WHERE student_id = ?',
            'SELECT f.*, u.username as creator_name FROM follow_ups f LEFT JOIN users u ON f.created_by = u.user_id WHERE f.student_id = ? ORDER BY f.created_at DESC'
        ];

        const results = {};
        const executeQuery = (index) => {
            if (index === queries.length) return resolve(results);

            db.query(queries[index], [studentId], (err, rows) => {
                if (err) return reject(err);

                if (index === 0) results.student = rows[0];
                else if (index === 1) results.study = rows;
                else if (index === 2) results.migration = rows;
                else if (index === 3) results.coaching = rows;
                else if (index === 4) results.visa = rows;
                else if (index === 5) results.work = rows;
                else if (index === 6) results.followups = rows;

                executeQuery(index + 1);
            });
        };
        executeQuery(0);
    });
};

const createOrUpdateStudent = (data, userId, userBranchId) => {
    const { student, programs } = data;
    return new Promise((resolve, reject) => {
        db.getConnection(async function (err, connection) {
            if (err) return reject(err);

            try {
                await new Promise((res, rej) => connection.beginTransaction(err => err ? rej(err) : res()));

                // 1. Upsert Student Profile
                const studentResult = await new Promise((res, rej) => {
                    connection.query(
                        'CALL sp_UpsertStudent(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                        [
                            student.id || 0, student.student_name,
                            student.mobile_country_code || '', student.mobile_number,
                            student.phone_country_code || '', student.phone_number || '',
                            student.email || '', toBoolInt(student.whatsapp),
                            toBoolInt(student.botim), toBoolInt(student.telegram),
                            toBoolInt(student.phone_whatsapp), toBoolInt(student.phone_botim),
                            toBoolInt(student.phone_telegram),
                            student.enquiry_source || '', toBoolInt(student.study_interested),
                            toBoolInt(student.migration_interested), toBoolInt(student.coaching_interested),
                            toBoolInt(student.visa_interested), toBoolInt(student.work_interested),
                            student.branch_id || userBranchId, userId,
                            student.assigned_to || null
                        ],
                        (err, results) => err ? rej(err) : res(results)
                    );
                });

                const studentId = studentResult[0][0].student_id;

                // 2. Clear existing programs if updating
                if (student.id) {
                    const tables = ['student_study_programs', 'student_migration', 'student_coaching', 'student_visa', 'student_work'];
                    for (const table of tables) {
                        await new Promise((res, rej) => {
                            connection.query(`DELETE FROM ${table} WHERE student_id = ?`, [studentId], err => err ? rej(err) : res());
                        });
                    }
                }

                // 3. Insert new programs
                if (programs) {
                    const programTypes = [
                        { key: 'study', table: 'student_study_programs', columns: 'student_id, country, level, field, intake, year', params: p => [studentId, p.country, p.level, p.field, p.intake, p.year] },
                        { key: 'migration', table: 'student_migration', columns: 'student_id, country, occupation, category', params: p => [studentId, p.country, p.occupation, p.category] },
                        { key: 'coaching', table: 'student_coaching', columns: 'student_id, course, batch', params: p => [studentId, p.course, p.batch] },
                        { key: 'visa', table: 'student_visa', columns: 'student_id, country, category', params: p => [studentId, p.country, p.category] },
                        { key: 'work', table: 'student_work', columns: 'student_id, country, occupation', params: p => [studentId, p.country, p.occupation] }
                    ];

                    for (const type of programTypes) {
                        if (programs[type.key]) {
                            for (const p of programs[type.key]) {
                                await new Promise((res, rej) => {
                                    connection.query(
                                        `INSERT INTO ${type.table} (${type.columns}) VALUES (${type.columns.split(',').map(() => '?').join(',')})`,
                                        type.params(p),
                                        err => err ? rej(err) : res()
                                    );
                                });
                            }
                        }
                    }
                }

                await new Promise((res, rej) => connection.commit(err => err ? rej(err) : res()));
                resolve({ id: studentId, message: 'Student and programs saved successfully' });

            } catch (error) {
                await new Promise((res) => connection.rollback(() => res()));
                reject(error);
            } finally {
                connection.release();
            }
        });
    });
};

const deleteStudent = (studentId) => {
    return new Promise((resolve, reject) => {
        db.query('CALL sp_DeleteStudent(?)', [studentId], (err, results) => {
            if (err) return reject(err);

            const affectedRows = results[0][0].affected_rows;
            if (affectedRows === 0) {
                return reject({ status: 404, message: 'Student not found' });
            }
            resolve({ message: 'Student deleted successfully' });
        });
    });
};

const getStudentApplication = (studentId) => {
    return new Promise((resolve, reject) => {
        db.query('CALL sp_GetStudentApplication(?)', [studentId], (err, results) => {
            if (err) return reject(err);
            resolve({
                application: results[0] && results[0][0] ? results[0][0] : null,
                education_list: results[1] || [],
                work_experience_list: results[2] || [],
                language_tests: results[3] || [],
                admission_tests: results[4] || [],
                spouse_education: results[5] || [],
                spouse_work: results[6] || [],
                relatives: results[7] || [],
                children: results[8] || [],
                suggestedPrograms: results[9] || [],
                skill_assessment_list: results[10] || [],
                lang_interest: (results[11] || []).filter(li => !li.is_spouse),
                spouse_lang_interest: (results[11] || []).filter(li => li.is_spouse),
                adm_interest: results[12] || []
            });
        });
    });
};

const saveStudentApplication = (studentId, data) => {
    const { application, children, suggestedPrograms, education_list, work_experience_list, language_tests, admission_tests, spouse_education, spouse_work, relatives } = data;
    
    return new Promise((resolve, reject) => {
        db.getConnection(async function (err, connection) {
            if (err) return reject(err);

            const pConn = connection.promise();

            try {
                await pConn.beginTransaction();

                // 1. Upsert Application Details (Core)
                const [results] = await pConn.query(
                    'CALL sp_UpsertStudentApplication_Core(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                    [
                        studentId,
                        application.passport_name || '',
                        application.age || 0,
                        normalizeDate(application.dob),
                        application.gender || 'Other',
                        application.marital_status || '',
                        application.spouse_accompanying ? 1 : 0,
                        application.address_country || '',
                        application.address_state || '',
                        application.address_suburb || '',
                        application.contact1_code || '',
                        application.contact1 || '',
                        application.contact2_code || '',
                        application.contact2 || '',
                        application.email || '',
                        application.citizenship_country || '',
                        application.passport_country || '',
                        application.has_second_passport ? 1 : 0,
                        application.second_passport_country || '',
                        application.highest_education || '',
                        application.education_field || '',
                        application.spouse_age || null,
                        toBoolInt(application.spouse_has_language_test),
                        toBoolInt(application.contact1_whatsapp),
                        toBoolInt(application.contact1_bot),
                        toBoolInt(application.contact1_telegram),
                        toBoolInt(application.contact2_whatsapp),
                        toBoolInt(application.contact2_bot),
                        toBoolInt(application.contact2_telegram),
                        toBoolInt(application.has_skill_assessment),
                        toBoolInt(application.skill_assessment_interest),
                        toBoolInt(application.interested_in_lang_coaching),
                        toBoolInt(application.interested_in_admission_coaching)
                    ]
                );

                const applicationId = results[0][0].app_id;

                // 2. Clear existing children, programs, skills, and interests (Full Cleanup)
                await pConn.query('CALL sp_DeleteApplicationChildrenFull(?)', [applicationId]);
                await pConn.query('CALL sp_DeleteApplicationSkillsFull(?)', [applicationId]);
                await pConn.query('CALL sp_DeleteApplicationLangInterestFull(?)', [applicationId]);
                await pConn.query('CALL sp_DeleteApplicationAdmInterestFull(?)', [applicationId]);

                // 3. Insert Modular Child Records
                
                // Interests
                if (application.interested_in_lang_coaching) {
                    await pConn.query('CALL sp_AddApplicationLangInterest(?, ?, ?, ?)', 
                    [applicationId, application.lang_coaching_course || '', normalizeDate(application.expected_lang_coaching_date), 0]);
                }
                if (application.spouse_interested_in_lang_coaching) {
                    await pConn.query('CALL sp_AddApplicationLangInterest(?, ?, ?, ?)', 
                    [applicationId, application.spouse_lang_coaching_course || '', normalizeDate(application.spouse_expected_lang_coaching_date), 1]);
                }
                if (application.interested_in_admission_coaching) {
                    await pConn.query('CALL sp_AddApplicationAdmInterest(?, ?, ?)', 
                    [applicationId, application.admission_coaching_course || '', normalizeDate(application.expected_admission_coaching_date)]);
                }

                // 3. Insert Modular Child Records
                
                // Skill Assessments
                if (application.skill_assessment_list && application.skill_assessment_list.length > 0) {
                    const isInterest = toBoolInt(application.skill_assessment_interest);
                    for (const skill of application.skill_assessment_list) {
                        await pConn.query('CALL sp_AddApplicationSkill(?, ?, ?, ?, ?, ?, ?)', 
                        [applicationId, skill.country, skill.authority, skill.status, skill.sub_status, isInterest, skill.remarks || null]);
                    }
                }

                // 3. Insert Modular Child Records (Looping in Backend)
                
                // Education List
                if (education_list && education_list.length > 0) {
                    for (const edu of education_list) {
                        await pConn.query('CALL sp_AddApplicationEducation(?, ?, ?, ?, ?, ?, ?, ?)', 
                        [applicationId, edu.country, edu.level, edu.field, edu.status, normalizeDate(edu.expected_completion), toBoolInt(edu.is_highest), edu.edu_type || 'highest']);
                    }
                }

                // Work Experience
                if (work_experience_list && work_experience_list.length > 0) {
                    for (const work of work_experience_list) {
                        await pConn.query('CALL sp_AddApplicationWork(?, ?, ?, ?, ?, ?, ?, ?, ?)', 
                        [applicationId, work.country, work.job_title, work.status || 'Completed', normalizeDate(work.start_date), work.work_years || 0, work.work_months || 0, toBoolInt(work.is_current), work.work_type || 'curr_country']);
                    }
                }

                // Language Tests
                if (language_tests && language_tests.length > 0) {
                    for (const test of language_tests) {
                        await pConn.query('CALL sp_AddApplicationLangTest(?, ?, ?, ?, ?, ?, ?, ?)', 
                        [applicationId, test.type, test.reading, test.writing, test.speaking, test.listening, test.overall, toBoolInt(test.is_spouse)]);
                    }
                }

                // Admission Tests
                if (admission_tests && admission_tests.length > 0) {
                    for (const test of admission_tests) {
                        await pConn.query('CALL sp_AddApplicationAdmTest(?, ?, ?, ?, ?, ?)', 
                        [applicationId, test.type, test.quant, test.verbal, test.data_insights, test.overall]);
                    }
                }

                // Spouse Education
                if (spouse_education && spouse_education.length > 0) {
                    for (const edu of spouse_education) {
                        await pConn.query('CALL sp_AddApplicationSpouseEdu(?, ?, ?, ?, ?, ?, ?)', 
                        [applicationId, edu.country, edu.level, edu.field, edu.status, normalizeDate(edu.expected_completion), edu.edu_type || 'highest']);
                    }
                }

                // Spouse Work
                if (spouse_work && spouse_work.length > 0) {
                    for (const work of spouse_work) {
                        await pConn.query('CALL sp_AddApplicationSpouseWork(?, ?, ?, ?, ?, ?, ?, ?)', 
                        [applicationId, work.country, work.job_title, work.status || 'Completed', normalizeDate(work.start_date), work.work_years || 0, work.work_months || 0, work.work_type || 'other']);
                    }
                }

                // Relatives
                if (relatives && relatives.length > 0) {
                    for (const rel of relatives) {
                        await pConn.query('CALL sp_AddApplicationRelative(?, ?, ?, ?)', 
                        [applicationId, rel.country, rel.relationship, rel.related_to]);
                    }
                }

                // Legacy Children (Accompanying)
                if (children && children.length > 0) {
                    for (const child of children) {
                        await pConn.query('INSERT INTO application_children (application_id, age, is_accompanying) VALUES (?, ?, ?)',
                        [applicationId, child.age, toBoolInt(child.is_accompanying)]);
                    }
                }

                // Suggested Programs
                if (suggestedPrograms && suggestedPrograms.length > 0) {
                    for (const prog of suggestedPrograms) {
                        await pConn.query(
                            'INSERT INTO suggested_programs (application_id, issystem, program_type, program, applied_for, details, details2, details3, status, sub_status, remarks, is_selected, branch_id, department_id, assigned_to) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                            [applicationId, toBoolInt(prog.issystem !== undefined ? prog.issystem : prog._isSystem), prog.type || 'OTHER', prog.program, prog.applied_for || null, prog.details || null, prog.details2 || null, prog.details3 || null, prog.status || null, prog.sub_status || null, prog.remarks || null, toBoolInt(prog.is_selected), prog.branch_id || null, prog.department_id || null, prog.assigned_to || null]
                        );
                    }
                }

                await pConn.commit();
                resolve({ message: 'Application saved successfully', applicationId });

            } catch (error) {
                console.error('SERVER ERROR IN saveStudentApplication:', error);
                await pConn.rollback();
                reject(error);
            } finally {
                connection.release();
            }
        });
    });
};

const getStudentRegistration = (studentId) => {
    return new Promise((resolve, reject) => {
        db.query('CALL sp_GetStudentRegistration(?)', [studentId], (err, results) => {
            if (err) return reject(err);
            resolve({
                application: results[0] && results[0][0] ? results[0][0] : null,
                education_list: results[1] || [],
                work_experience_list: results[2] || [],
                language_tests: results[3] || [],
                children: results[4] || [],
                suggestedPrograms: results[5] || [],
                spouse_education: results[6] || [],
                spouse_work: results[7] || [],
                relatives: results[8] || [],
                skill_assessment_list: results[9] || [],
                lang_interest: (results[10] || []).filter(li => !li.is_spouse),
                spouse_lang_interest: (results[10] || []).filter(li => li.is_spouse),
                adm_interest: results[11] || []
            });
        });
    });
};

const saveStudentRegistration = (studentId, data) => {
    const { application: app, children, suggestedPrograms, education_list, work_experience_list, language_tests, admission_tests, spouse_education, spouse_work, relatives } = data;
    
    return new Promise((resolve, reject) => {
        db.getConnection(async function (err, connection) {
            if (err) return reject(err);
            const pConn = connection.promise();

            try {
                await pConn.beginTransaction();

                // 1. Upsert Registration Details (Core)
                const [results] = await pConn.query(
                    'CALL sp_UpsertStudentRegistration_Core(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                    [
                        studentId,
                        app.passport_name || '',
                        app.first_name || '',
                        app.last_name || '',
                        app.age || 0,
                        normalizeDate(app.dob),
                        app.gender || 'Other',
                        app.marital_status || '',
                        app.spouse_accompanying ? 1 : 0,
                        app.address_country || '',
                        app.address_state || '',
                        app.address_suburb || '',
                        app.address_postcode || '',
                        app.contact1_code || '',
                        app.contact1 || '',
                        app.contact2_code || '',
                        app.contact2 || '',
                        app.email || '',
                        app.citizenship_country || '',
                        app.passport_country || '',
                        app.has_second_passport ? 1 : 0,
                        app.second_passport_country || '',
                        app.highest_education || '',
                        app.education_field || '',
                        app.spouse_age || null,
                        toBoolInt(app.spouse_has_language_test),
                        toBoolInt(app.contact1_whatsapp),
                        toBoolInt(app.contact1_bot),
                        toBoolInt(app.contact1_telegram),
                        toBoolInt(app.contact2_whatsapp),
                        toBoolInt(app.contact2_bot),
                        toBoolInt(app.contact2_telegram),
                        toBoolInt(app.has_skill_assessment),
                        toBoolInt(app.skill_assessment_interest),
                        toBoolInt(app.interested_in_lang_coaching),
                        toBoolInt(app.interested_in_admission_coaching),
                        toBoolInt(app.has_language_test),
                        toBoolInt(app.has_admission_test)
                    ]
                );

                const registrationId = results[0][0].reg_id;

                // 2. Clear existing children, programs, skills, and interests (Full Cleanup)
                await pConn.query('CALL sp_DeleteRegistrationChildrenFull(?)', [registrationId]);
                await pConn.query('CALL sp_DeleteRegistrationSkillsFull(?)', [registrationId]);
                await pConn.query('CALL sp_DeleteRegistrationLangInterestFull(?)', [registrationId]);
                await pConn.query('CALL sp_DeleteRegistrationAdmInterestFull(?)', [registrationId]);

                // 3. Insert Modular Child Records
                
                // Interests
                if (app.interested_in_lang_coaching) {
                    await pConn.query('CALL sp_AddRegistrationLangInterest(?, ?, ?, ?)', 
                    [registrationId, app.lang_coaching_course || '', normalizeDate(app.expected_lang_coaching_date), 0]);
                }
                if (app.spouse_interested_in_lang_coaching) {
                    await pConn.query('CALL sp_AddRegistrationLangInterest(?, ?, ?, ?)', 
                    [registrationId, app.spouse_lang_coaching_course || '', normalizeDate(app.spouse_expected_lang_coaching_date), 1]);
                }
                if (app.interested_in_admission_coaching) {
                    await pConn.query('CALL sp_AddRegistrationAdmInterest(?, ?, ?)', 
                    [registrationId, app.admission_coaching_course || '', normalizeDate(app.expected_admission_coaching_date)]);
                }

                // 3. Insert Modular Child Records
                
                // Skill Assessments
                if (app.skill_assessment_list && app.skill_assessment_list.length > 0) {
                    const isInterest = toBoolInt(app.skill_assessment_interest);
                    for (const skill of app.skill_assessment_list) {
                        await pConn.query('CALL sp_AddRegistrationSkill(?, ?, ?, ?, ?, ?, ?)', 
                        [registrationId, skill.country, skill.authority, skill.status, skill.sub_status, isInterest, skill.remarks || null]);
                    }
                }

                // 3. Insert Modular Child Records (Looping in Backend)
                
                // Education List
                if (education_list && education_list.length > 0) {
                    for (const edu of education_list) {
                        await pConn.query('CALL sp_AddRegistrationEducation(?, ?, ?, ?, ?, ?, ?, ?)', 
                        [registrationId, edu.country, edu.level, edu.field, edu.status, normalizeDate(edu.expected_completion), toBoolInt(edu.is_highest), edu.edu_type || 'highest']);
                    }
                }

                // Work Experience
                if (work_experience_list && work_experience_list.length > 0) {
                    for (const work of work_experience_list) {
                        await pConn.query('CALL sp_AddRegistrationWork(?, ?, ?, ?, ?, ?, ?, ?, ?)', 
                        [registrationId, work.country, work.job_title, work.status || 'Completed', normalizeDate(work.start_date), work.work_years || 0, work.work_months || 0, work.type || 'previous', work.work_type || 'curr_country']);
                    }
                }

                // Language Tests
                if (language_tests && language_tests.length > 0) {
                    for (const test of language_tests) {
                        await pConn.query('CALL sp_AddRegistrationLangTest(?, ?, ?, ?, ?, ?, ?, ?)', 
                        [registrationId, test.type || test.test_type, test.reading, test.writing, test.speaking, test.listening, test.overall || '', toBoolInt(test.is_spouse)]);
                    }
                }

                // Admission Tests
                if (admission_tests && admission_tests.length > 0) {
                    for (const test of admission_tests) {
                        await pConn.query('CALL sp_AddRegistrationAdmissionTest(?, ?, ?, ?, ?, ?)', 
                        [registrationId, test.type || test.test_type, test.quant, test.verbal, test.data_insights, test.overall || '']);
                    }
                }

                // Spouse Education
                if (spouse_education && spouse_education.length > 0) {
                    for (const edu of spouse_education) {
                        await pConn.query('CALL sp_AddRegistrationSpouseEdu(?, ?, ?, ?, ?, ?, ?)', 
                        [registrationId, edu.country, edu.level, edu.field, edu.status, normalizeDate(edu.expected_completion), edu.edu_type || 'highest']);
                    }
                }

                // Spouse Work
                if (spouse_work && spouse_work.length > 0) {
                    for (const work of spouse_work) {
                        await pConn.query('CALL sp_AddRegistrationSpouseWork(?, ?, ?, ?, ?, ?, ?, ?)', 
                        [registrationId, work.country, work.job_title, work.status || 'Completed', normalizeDate(work.start_date), work.work_years || 0, work.work_months || 0, work.work_type || 'other']);
                    }
                }

                // Relatives
                if (relatives && relatives.length > 0) {
                    for (const rel of relatives) {
                        await pConn.query('INSERT INTO registration_relatives (registration_id, country, relationship, related_to) VALUES (?, ?, ?, ?)',
                        [registrationId, rel.country, rel.relationship, rel.related_to]);
                    }
                }

                // Legacy Children (Accompanying)
                if (children && children.length > 0) {
                    for (const child of children) {
                        await pConn.query('INSERT INTO registration_children (registration_id, age, is_accompanying) VALUES (?, ?, ?)',
                        [registrationId, child.age, toBoolInt(child.is_accompanying)]);
                    }
                }

                // Suggested Programs
                if (suggestedPrograms && suggestedPrograms.length > 0) {
                    for (const prog of suggestedPrograms) {
                        await pConn.query(
                            'INSERT INTO registration_suggested_programs (registration_id, issystem, program_type, program, applied_for, details, details2, details3, status, sub_status, remarks, is_selected, branch_id, department_id, assigned_to) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                            [registrationId, toBoolInt(prog.issystem !== undefined ? prog.issystem : prog._isSystem), prog.type || 'OTHER', prog.program, prog.applied_for || null, prog.details || null, prog.details2 || null, prog.details3 || null, prog.status || null, prog.sub_status || null, prog.remarks || null, toBoolInt(prog.is_selected), prog.branch_id || null, prog.department_id || null, prog.assigned_to || null]
                        );
                    }
                }

                await pConn.commit();
                resolve({ message: 'Registration saved successfully', registrationId });

            } catch (error) {
                console.error('SERVER ERROR IN saveStudentRegistration:', error);
                await pConn.rollback();
                reject(error);
            } finally {
                connection.release();
            }
        });
    });
};

module.exports = {
    getStudents,
    getStudentById,
    createOrUpdateStudent,
    deleteStudent,
    getStudentApplication,
    saveStudentApplication,
    getStudentRegistration,
    saveStudentRegistration
};
