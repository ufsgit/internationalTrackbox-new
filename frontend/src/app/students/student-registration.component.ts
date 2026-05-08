import { Component, OnInit, signal, effect } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, ActivatedRoute, Router } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { StudentService } from '../shared/student.service';
import { UserService } from '../shared/user.service';
import { DialogService } from '../shared/dialog.service';
import { SettingsService } from '../shared/settings.service';
import { LoadingService } from '../shared/loading.service';


@Component({
    selector: 'app-student-registration',
    standalone: true,
    imports: [CommonModule, RouterModule, FormsModule],
    templateUrl: './student-registration.component.html',
    styleUrls: ['./student-registration.component.css']
})
export class StudentRegistrationComponent implements OnInit {
    studentId: number = 0;
    assessmentData = signal<any>(null);
    registrationLoaded = false;
    student: any = {};
    studentPrograms: any = {};
    application: any = {
        passport_name: '',
        first_name: '',
        last_name: '',
        contact1: '',
        contact1_whatsapp: null,
        contact1_bot: null,
        contact1_telegram: null,
        contact2: '',
        contact2_whatsapp: null,
        contact2_bot: null,
        contact2_telegram: null,
        email: '',
        gender: '',
        marital_status: 'Single',
        spouse_accompanying: false,
        spouse_age: null,
        spouse_edu_level: '',
        spouse_edu_country: '',
        spouse_edu_field: '',
        spouse_has_work_experience: false,
        spouse_work_experience_list: [],
        spouse_work_experience_years: null,
        spouse_education: [],
        has_canadian_edu: false,
        has_australian_edu: false,
        has_aus_specialised_edu: false,
        has_nz_edu: false,
        has_work_experience: false,
        work_experience: '',
        work_experience_list: [],
        has_language_test: false,
        has_admission_test: false,
        has_relatives: false,
        has_relatives_abroad: false,
        relatives_list: [],
        spouse_canadian_edu: false,
        spouse_australian_edu: false,
        spouse_aus_specialised_edu: false,
        migration_data: {},
        migration_spouse_data: {},
        relatives_data: {},
        passport_country: '',
        has_second_passport: false,
        second_passport_country: '',
        education_country: '',
        highest_education_status: 'Completed',
        highest_education_expected: '',
        spouse_edu_status: 'Completed',
        spouse_edu_expected: '',
        has_children: false,
        address_country: '',
        address_state: '',
        address_suburb: '',
        address_postcode: '',
        mobile_country_code: '+91',
        phone_country_code: '+91',
        language_test_list: [],
        admission_test_list: [],
        education_data: { additional: [] },
        has_skill_assessment: null,
        skill_assessment_interest: null,
        skill_assessment_list: [],
        interested_in_lang_coaching: false,
        lang_coaching_course: '',
        expected_lang_coaching_date: '',
        interested_in_admission_coaching: false,
        admission_coaching_course: '',
        expected_admission_coaching_date: '',
        spouse_interested_in_lang_coaching: false,
        spouse_lang_coaching_course: '',
        spouse_expected_lang_coaching_date: '',
        has_language_interest: false,
        has_admission_interest: false
    };
    children: any[] = [];
    suggestedPrograms: any[] = [];

    rowDepartments: { [key: number]: any[] } = {};
    rowStaff: { [key: number]: any[] } = {};

    branches: any[] = [];
    allDepartments: any[] = [];
    allStaff: any[] = [];

    get isAddressCountryMandatory(): boolean {
        return this.hasInterestedProgram(['MIGRATION', 'VISA', 'WORK']);
    }

    get isAddressStateMandatory(): boolean {
        return this.hasInterestedProgram(['MIGRATION', 'VISA', 'WORK']);
    }

    get isAddressSuburbMandatory(): boolean {
        return this.hasInterestedProgram(['MIGRATION']);
    }

    hasInterestedProgram(types: string[]): boolean {
        return this.suggestedPrograms.some(p => types.includes(p.type));
    }

    onNumberInput(event: any, field: string) {
        const value = event.target.value.replace(/\D/g, '');
        this.application[field] = value;
    }


    allAppStatuses: any[] = [];
    appSubStatuses: { [key: number]: any[] } = {};

    lookups: any = {
        countries: [],
        levels: [],
        fields: [],
        categories: [],
        coachingCourses: [],
        admissionCourses: [],
        languageCourses: [],
        boardAuthorities: []
    };

    constructor(
        private route: ActivatedRoute,
        private router: Router,
        private studentService: StudentService,
        private userService: UserService,
        private dialogService: DialogService,
        private settingsService: SettingsService,
        private loadingService: LoadingService
    ) {
        // Effect to auto-fill the form when assessment data is fetched
        effect(() => {
            const data = this.assessmentData();
            if (data && data.application) {
                console.log('AUTO-FILL: Checking for missing fields from Assessment data...');
                this.patchFromAssessment(data);
            }
        });
    }

    ngOnInit() {
        this.route.params.subscribe(params => {
            this.studentId = +params['id'];
            if (this.studentId) {
                this.loadInitialData();
                this.loadApplication();
                this.loadApplicationStatuses();
                this.fetchAssessmentData();
            }
        });
    }

    fetchAssessmentData() {
        this.studentService.getStudentAssessment(this.studentId).subscribe({
            next: (res) => {
                if (res) {
                    // Setting the signal triggers the effect() which calls patchFromAssessment.
                    // Do NOT call patchFromAssessment directly here to avoid double execution.
                    this.assessmentData.set(res);
                }
            },
            error: (err) => console.error('Error fetching assessment data:', err)
        });
    }

    loadApplicationStatuses() {
        this.loadingService.show();
        this.settingsService.getApplicationStatuses().subscribe({
            next: (data) => {
                this.loadingService.hide();
                this.allAppStatuses = data;
                this.resolveStatusIds();
            },
            error: () => this.loadingService.hide()
        });

        this.loadingService.show();
        this.settingsService.getApplicationSubStatuses().subscribe({
            next: (data) => {
                this.loadingService.hide();
                const grouped: any = {};
                data.forEach(ss => {
                    if (!grouped[ss.status_id]) grouped[ss.status_id] = [];
                    grouped[ss.status_id].push(ss);
                });
                this.appSubStatuses = grouped;
            },
            error: () => this.loadingService.hide()
        });
    }

    resolveStatusIds() {
        if (!this.allAppStatuses.length || !this.suggestedPrograms.length) return;
        this.suggestedPrograms.forEach(p => {
            const selected = this.allAppStatuses.find(s => s.name === p.status && (s.categories || []).includes(p.type));
            p.status_id = selected ? selected.status_id : null;
        });
    }

    getFilteredStatuses(category: string) {
        if (!category) return [];
        // Match category with the list of categories in status
        const cat = category.toUpperCase();
        return this.allAppStatuses.filter(s => (s.categories || []).includes(cat));
    }

    validateNumeric(field: string, event: any) {
        let val = event.target.value;
        let filtered = val.replace(/[^0-9]/g, '');
        if (filtered.length > 10) filtered = filtered.substring(0, 10);
        this.application[field] = filtered;
        event.target.value = filtered;
    }

    onlyNumberKey(event: any) {
        const charCode = (event.which) ? event.which : event.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            return false;
        }
        return true;
    }

    onStatusChange(p: any) {
        // Find the status_id for the selected status name to filter sub-statuses
        const selected = this.allAppStatuses.find(s => s.name === p.status && (s.categories || []).includes(p.type));
        p.status_id = selected ? selected.status_id : null;
        p.sub_status = ''; // reset sub-status on main status change
    }

    loadInitialData() {
        this.loadingService.show();
        this.studentService.getLookups().subscribe({
            next: (data: any) => {
                this.loadingService.hide();
                this.lookups = data;
            },
            error: () => this.loadingService.hide()
        });

        this.loadingService.show();
        this.studentService.getBranches().subscribe({
            next: (data) => {
                this.loadingService.hide();
                this.branches = data;
            },
            error: () => this.loadingService.hide()
        });

        this.loadingService.show();
        this.studentService.getStudentById(this.studentId).subscribe({
            next: (res) => {
                this.loadingService.hide();
                if (!res || !res.student) return;

                console.log('DEBUG: Student API Response:', res);
                this.student = res.student;

                // Map flat response keys to studentPrograms object
                this.studentPrograms = {
                    study: res.study || [],
                    migration: res.migration || [],
                    coaching: res.coaching || [],
                    visa: res.visa || [],
                    work: res.work || []
                };
                console.log('DEBUG: Mapped Programs:', this.studentPrograms);

                this.initializeMigrationData();
                this.prePopulateFields();
                if (this.suggestedPrograms.length === 0) {
                    this.syncSuggestedPrograms();
                }
            },
            error: () => this.loadingService.hide()
        });
    }

    prePopulateFields() {
        if (!this.student || !this.application) return;

        // Basic Profile Sync
        if (!this.application.passport_name) this.application.passport_name = this.student.student_name;
        if (!this.application.contact1) this.application.contact1 = this.student.mobile_number;
        if (!this.application.mobile_country_code) this.application.mobile_country_code = this.student.mobile_country_code;
        if (!this.application.contact2) this.application.contact2 = this.student.phone_number;
        if (!this.application.phone_country_code) this.application.phone_country_code = this.student.phone_country_code;
        if (!this.application.email) this.application.email = this.student.email;

        // Split name into first and last for registration if empty
        if (this.student.student_name && (!this.application.first_name || !this.application.last_name)) {
            const names = this.student.student_name.trim().split(' ');
            if (!this.application.first_name) this.application.first_name = names[0];
            if (names.length > 1 && !this.application.last_name) {
                this.application.last_name = names.slice(1).join(' ');
            }
        }

        // Auto-fill communication preferences from student profile if not already set (checks for undefined or null)
        const isSet = (val: any) => val !== undefined && val !== null;

        if (!isSet(this.application.contact1_whatsapp)) this.application.contact1_whatsapp = !!this.student.whatsapp;
        if (!isSet(this.application.contact1_bot))      this.application.contact1_bot      = !!this.student.botim;
        if (!isSet(this.application.contact1_telegram)) this.application.contact1_telegram = !!this.student.telegram;
        if (!isSet(this.application.contact2_whatsapp)) this.application.contact2_whatsapp = !!this.student.phone_whatsapp;
        if (!isSet(this.application.contact2_bot))      this.application.contact2_bot      = !!this.student.phone_botim;
        if (!isSet(this.application.contact2_telegram)) this.application.contact2_telegram = !!this.student.phone_telegram;
    }

    loadApplication() {
        this.loadingService.show();
        this.studentService.getStudentRegistration(this.studentId).subscribe({
            next: (data) => {
                this.loadingService.hide();
                const formatMonth = (d: string) => d ? d.substring(0, 7) : '';
                if (data && data.application) {
                    this.registrationLoaded = true;
                    this.application = data.application;
                    // Ensure boolean types
                    const appObj: any = this.application;
                    ['spouse_accompanying', 'has_canadian_edu', 'has_australian_edu', 'has_aus_specialised_edu',
                        'has_nz_edu', 'has_work_experience', 'has_language_test', 'has_admission_test', 'has_relatives',
                        'spouse_canadian_edu', 'spouse_australian_edu', 'spouse_aus_specialised_edu', 'has_second_passport',
                        'spouse_has_work_experience', 'spouse_has_other_work_experience', 'has_children',
                        'contact1_whatsapp', 'contact1_bot', 'contact1_telegram',
                        'contact2_whatsapp', 'contact2_bot', 'contact2_telegram',
                        'has_language_interest', 'has_admission_interest',
                        'has_skill_assessment', 'skill_assessment_interest'].forEach(key => {
                            appObj[key] = !!appObj[key];
                        });

                    // Language Interests
                    if (data.lang_interest && data.lang_interest.length > 0) {
                        this.application.interested_in_lang_coaching = true;
                        this.application.lang_coaching_course = data.lang_interest[0].course;
                        this.application.expected_lang_coaching_date = data.lang_interest[0].expected_date ? data.lang_interest[0].expected_date.substring(0, 10) : '';
                    }

                    // Spouse Language Interests
                    if (data.spouse_lang_interest && data.spouse_lang_interest.length > 0) {
                        this.application.spouse_interested_in_lang_coaching = true;
                        this.application.spouse_lang_coaching_course = data.spouse_lang_interest[0].course;
                        this.application.spouse_expected_lang_coaching_date = data.spouse_lang_interest[0].expected_date ? data.spouse_lang_interest[0].expected_date.substring(0, 10) : '';
                    }

                    // Admission Interests
                    if (data.adm_interest && data.adm_interest.length > 0) {
                        this.application.interested_in_admission_coaching = true;
                        this.application.admission_coaching_course = data.adm_interest[0].course;
                        this.application.expected_admission_coaching_date = data.adm_interest[0].expected_date ? data.adm_interest[0].expected_date.substring(0, 10) : '';
                    }
                } else {
                    // No saved registration — new form, assessment data will fill it
                    this.registrationLoaded = false;
                }
                const app: any = this.application;
                if (app) {
                    if (app.contact1_code) app.mobile_country_code = app.contact1_code;
                    if (app.contact2_code) app.phone_country_code = app.contact2_code;

                    this.prePopulateFields();

                    if (app.dob) {
                        if (app.dob.includes('T')) {
                            const d = new Date(app.dob);
                            app.dob = `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`;
                        }
                    }

                    // --- Relational Re-assembly moved to the end of this method to ensure suggestedPrograms are fully loaded ---


                    this.application.language_test_list = [];
                    this.application.spouse_language_test_list = [];
                    if (data.language_tests) {
                        data.language_tests.forEach((t: any) => {
                            if (!t.test_type && !t.type) return;
                            if (t.is_spouse) this.application.spouse_language_test_list.push(t);
                            else this.application.language_test_list.push(t);
                        });
                    }
                    this.children = (data.children || []).map((c: any) => ({
                        ...c,
                        is_accompanying: !!c.is_accompanying
                    }));
                    if (this.children.length > 0) {
                        this.application.has_children = true;
                    }
                    this.application.skill_assessment_list = data.skill_assessment_list || [];
                    this.suggestedPrograms = data.suggestedPrograms || [];

                    // --- Parse JSON Blobs (Always) ---
                    ['education_data', 'migration_data', 'relatives_data', 'migration_spouse_data'].forEach(key => {
                        if (typeof this.application[key] === 'string' && this.application[key]) {
                            try { this.application[key] = JSON.parse(this.application[key]); } catch (e) { this.application[key] = {}; }
                        }
                        if (!this.application[key] || typeof this.application[key] !== 'object') {
                            this.application[key] = (key === 'education_data') ? { additional: [] } : {};
                        }
                    });

                    // Ensure education_data structure
                    if (!this.application.education_data.additional) {
                        this.application.education_data.additional = [];
                    }

                    // Sync unmapped education properties
                    this.application.education_country = this.application.education_country || '';
                    this.application.highest_education_status = this.application.highest_education_status || 'Completed';
                    this.application.spouse_edu_country = this.application.education_data.spouse_edu_country || this.application.spouse_edu_country || '';
                    this.application.spouse_edu_level = this.application.education_data.spouse_edu_level || this.application.spouse_edu_level || '';
                    this.application.spouse_edu_field = this.application.education_data.spouse_edu_field || this.application.spouse_edu_field || '';
                    this.application.spouse_edu_status = this.application.education_data.spouse_edu_status || this.application.spouse_edu_status || 'Completed';
                    this.application.spouse_edu_expected = formatMonth(this.application.education_data.spouse_edu_expected || this.application.spouse_edu_expected);
                    
                    this.application.spouse_has_other_country_edu = this.application.education_data.spouse_has_other_country_edu || false;
                    this.application.spouse_education = this.application.education_data.spouse_education || [];
                    this.application.spouse_other_country_edu_list = this.application.education_data.spouse_other_country_edu_list || [];
                    
                    // If spouse_education contains ALL entries (legacy/mixed), re-distribute them
                    const allSpouseEdu = [...this.application.spouse_education];
                    if (allSpouseEdu.length > 0 && !this.application.spouse_edu_country) {
                        const highest = allSpouseEdu.filter(e => e.edu_type === 'highest' || !e.edu_type);
                        if (highest.length > 0) {
                            const first = highest[0];
                            this.application.spouse_edu_country = first.country;
                            this.application.spouse_edu_level = first.level;
                            this.application.spouse_edu_field = first.field;
                            this.application.spouse_edu_status = first.status || 'Completed';
                            this.application.spouse_edu_expected = formatMonth(first.expected_completion);
                            this.application.spouse_education = highest.slice(1);
                        }
                    }

                    // Sync unmapped test properties from JSON
                    this.application.language_test_list = this.application.education_data.language_test_list || this.application.language_test_list || [];
                    this.application.spouse_has_language_test = this.application.education_data.spouse_has_language_test || this.application.spouse_has_language_test || false;
                    this.application.spouse_language_test_list = this.application.education_data.spouse_language_test_list || this.application.spouse_language_test_list || [];
                    this.application.admission_test_list = this.application.education_data.admission_test_list || this.application.admission_test_list || [];

                    // Legacy work sync removed to prevent data overwriting

                    this.initializeMigrationData();

                    // Backward compatibility sync: Map flat fields to JSON for UI
                    const countriesToSync = [
                        { name: 'Canada', prefix: 'canadian' },
                        { name: 'Australia', prefix: 'australian' },
                        { name: 'New Zealand', prefix: 'nz', altPrefix: 'nz' }
                    ];

                    countriesToSync.forEach(c => {
                        const prefix = c.prefix;
                        const name = c.name;

                        // Education mapping
                        if (this.application.education_data[name]) {
                            if (this.application[`has_${prefix}_edu`]) this.application.education_data[name].has_edu = !!this.application[`has_${prefix}_edu`];
                            if (this.application[`${prefix}_edu_level`]) this.application.education_data[name].level = this.application[`${prefix}_edu_level`];
                            if (this.application[`${prefix}_edu_field`]) this.application.education_data[name].field = this.application[`${prefix}_edu_field`];
                        }

                        // Migration mapping (Applicant)
                        if (this.application.migration_data[name]) {
                            if (this.application[`has_${prefix}_edu`]) this.application.migration_data[name].has_edu = !!this.application[`has_${prefix}_edu`];
                            if (this.application[`${prefix}_work_years`]) this.application.migration_data[name].work_years = this.application[`${prefix}_work_years`];
                        }

                        // Migration mapping (Spouse)
                        if (this.application.migration_spouse_data[name]) {
                            if (this.application[`spouse_${prefix}_edu`]) this.application.migration_spouse_data[name].has_edu = !!this.application[`spouse_${prefix}_edu`];
                            if (this.application[`spouse_${prefix}_work`]) this.application.migration_spouse_data[name].work_years = this.application[`spouse_${prefix}_work`];
                        }
                    });
                }
                this.children = (data.children || []).map((c: any) => ({ ...c, is_accompanying: !!c.is_accompanying }));
                this.application.has_children = this.children.length > 0;
                this.suggestedPrograms = this.parseSuggestedPrograms(data.suggestedPrograms || []);

                // After loading, initialize cascading maps
                this.suggestedPrograms.forEach((p, i) => {
                    if (p.branch_id) this.loadRowDepartments(i, p.branch_id);
                    if (p.branch_id && p.department_id) this.loadRowStaff(i, p.branch_id, p.department_id);
                });

                this.resolveStatusIds();

                if (this.suggestedPrograms.length === 0) {
                    this.syncSuggestedPrograms();
                }

                // --- Relational Re-assembly ---
                // For existing registrations, we only wipe and re-map if we actually have relational data.
                // Otherwise, we keep the JSON data already loaded into this.application.
                const hasRelationalData = (data.education_list?.length > 0) || (data.work_experience_list?.length > 0) || 
                                          (data.spouse_education?.length > 0) || (data.spouse_work?.length > 0) ||
                                          (data.relatives?.length > 0) || (data.children?.length > 0);

                if (!this.registrationLoaded || hasRelationalData) {
                    this.application.education_data = { additional: [] };
                    this.application.migration_data = {};
                    this.application.relatives_data = {};
                    this.application.migration_spouse_data = {};

                    // Pre-initialize for all countries to ensure UI toggles work
                    this.migrationCountries.forEach(country => {
                        this.application.education_data[country] = { has_edu: false, additional_entries: [] };
                        this.application.migration_data[country] = { 
                            has_work: false, is_currently_working: false, has_other_work: false,
                            current_work_experience_list: [], other_work_experience_list: [] 
                        };
                        this.application.migration_spouse_data[country] = { 
                            has_edu: false, is_currently_working: false, has_other_work: false,
                            current_work_experience_list: [], other_work_experience_list: [],
                            additional_entries: []
                        };
                        this.application.relatives_data[country] = { has_rel: false };
                    });

                    this.application.work_experience_list = [];
                    this.application.other_country_edu_list = [];
                    this.application.spouse_education = [];
                    this.application.spouse_other_country_edu_list = [];
                    this.application.has_other_country_edu = false;
                    this.application.spouse_has_other_country_edu = false;
                    this.application.spouse_edu_country = '';
                    this.application.spouse_edu_level = '';
                    this.application.spouse_edu_field = '';
                    this.application.spouse_edu_status = 'Completed';
                    this.application.spouse_edu_expected = '';
                    this.application.spouse_work_experience_list = [];
                    this.application.spouse_other_work_experience_list = [];
                    this.application.spouse_has_work_experience = false;
                    this.application.has_work_experience = false;
                }

                // For existing registrations, load relational data from the saved registration.
                // For new registrations, patchFromAssessment (called below) will populate everything.
                if (this.registrationLoaded) {
                    this.mapRelationalData(data);
                }

                // If assessment data is already loaded, patch any missing fields.
                // For a new registration (registrationLoaded=false), this copies ALL assessment data.
                const assessment = this.assessmentData();
                if (assessment) {
                    this.patchFromAssessment(assessment);
                }

                this.loadingService.hide();
            },
            error: () => this.loadingService.hide()
        });
    }

    parseSuggestedPrograms(programs: any[]): any[] {
        return (programs || []).flatMap((p: any) => {
            const upperProg = (p.program || '').toUpperCase();
            let type = p.program_type || 'OTHER';
            
            if (!p.program_type) {
                if (upperProg.includes('STUDY')) type = 'STUDY';
                else if (upperProg.includes('MIGRATION')) type = 'MIGRATION';
                else if (upperProg.includes('VISA')) type = 'VISA';
                else if (upperProg.includes('WORK')) type = 'WORK';
                else if (upperProg.includes('COACHING')) type = 'COACHING';
            }

            let country = '', level = '', field = '', intake = '', year = '', occupation = '', category = '', course = '', batch = '', subType = 'default';

            if (type === 'STUDY') {
                country = p.program.replace(/STUDY/i, '').trim();
                const mainParts = p.details.split(' - ');
                const courseParts = (mainParts[0] || '').split(' ');
                const intakeParts = (mainParts[1] || '').split(' ');

                level = courseParts[0] || '';
                field = courseParts.slice(1).join(' ') || '';
                intake = intakeParts[0] || '';
                year = intakeParts[1] || '';
                subType = 'default';
            } else if (type === 'MIGRATION') {
                country = p.program.replace('MIGRATION', '').trim();
                const parts = p.details.split(' - ');
                occupation = parts[0] || '';
                category = parts[1] || '';
            } else if (type === 'VISA') {
                country = p.program.replace('VISA', '').trim();
                category = p.details;
            } else if (type === 'WORK') {
                country = p.program.replace('WORK', '').trim();
                occupation = p.details;
            } else if (type === 'COACHING') {
                const parts = p.details.split(' - ');
                course = parts[0] || '';
                batch = parts[1] || '';
            }

            return [{ ...p, type, subType, country, level, field, intake, year, occupation, category, course, batch }];
        });
    }

    addChild() {
        this.children.push({ age: null, is_accompanying: true });
    }

    onChildrenCountChange(count: any) {
        const targetCount = Math.max(0, parseInt(count) || 0);
        while (this.children.length < targetCount) {
            this.children.push({ age: null, is_accompanying: true });
        }
        while (this.children.length > targetCount) {
            this.children.pop();
        }
        this.application.has_children = this.children.length > 0;
    }

    onHasChildrenChange() {
        if (!this.application.has_children) {
            this.onChildrenCountChange(0);
        } else if (this.children.length === 0) {
            this.onChildrenCountChange(1);
        }
    }

    onMaritalStatusChange() {
        if (this.application.marital_status !== 'Married' && this.application.marital_status !== 'Common Law') {
            this.application.spouse_accompanying = false;
            this.application.spouse_age = null;
            // Also reset migration spouse data
            if (this.application.migration_spouse_data) {
                Object.keys(this.application.migration_spouse_data).forEach(k => {
                    this.application.migration_spouse_data[k].has_edu = false;
                    this.application.migration_spouse_data[k].has_work = false;
                });
            }
        }
    }

    removeChild(index: number) {
        this.children.splice(index, 1);
    }

    addSuggestedProgram(type: string) {
        if (type === 'STUDY') {
            const common = {
                type,
                program: type,
                details: '',
                status: '',
                sub_status: '',
                remarks: '',
                is_selected: true,
                branch_id: null,
                department_id: null,
                assigned_to: null,
                country: '',
                level: '', field: '', intake: '', year: '', occupation: '', category: '', course: '', batch: ''
            };
            this.suggestedPrograms.push({ ...common, subType: 'default' });
        } else {
            const newProg: any = {
                type,
                subType: 'default',
                program: type === 'OTHER' ? '' : type,
                details: '',
                status: '',
                sub_status: '',
                remarks: '',
                is_selected: true,
                branch_id: null,
                department_id: null,
                assigned_to: null,
                country: '', level: '', field: '', intake: '', year: '', occupation: '', category: '', course: '', batch: ''
            };
            this.suggestedPrograms.push(newProg);
        }
        this.initializeMigrationData();
    }

    onCountryChange(p: any) {
        this.syncSuggestedProgStrings(p);
        this.initializeMigrationData();
    }

    onBranchChange(index: number) {
        const p = this.suggestedPrograms[index];
        p.department_id = null;
        p.assigned_to = null;
        this.rowDepartments[index] = [];
        this.rowStaff[index] = [];
        if (p.branch_id) {
            this.loadRowDepartments(index, p.branch_id);
        }
    }

    onDepartmentChange(index: number) {
        const p = this.suggestedPrograms[index];
        p.assigned_to = null;
        this.rowStaff[index] = [];
        if (p.branch_id && p.department_id) {
            this.loadRowStaff(index, p.branch_id, p.department_id);
        }
    }

    loadRowDepartments(index: number, branchId: number) {
        this.studentService.getBranchDepartments(branchId).subscribe(data => {
            this.rowDepartments[index] = data;
        });
    }

    loadRowStaff(index: number, branchId: number, deptId: number) {
        this.studentService.getStaff(branchId, deptId).subscribe(data => {
            this.rowStaff[index] = data;
        });
    }

    syncSuggestedProgStrings(p: any) {
        if (p.type === 'STUDY') {
            p.program = `STUDY ${p.country || ''}`.trim();
            p.details = `${p.level || ''} ${p.field || ''} - ${p.intake || ''} ${p.year || ''}`.trim();
            if (p.details === '-') p.details = '';
        } else if (p.type === 'MIGRATION') {
            p.program = `MIGRATION ${p.country || ''}`.trim();
            p.details = `${p.occupation || ''} - ${p.category || ''}`.trim();
        } else if (p.type === 'VISA') {
            p.program = `VISA ${p.country || ''}`.trim();
            p.details = `${p.category || ''}`.trim();
        } else if (p.type === 'WORK') {
            p.program = `WORK ${p.country || ''}`.trim();
            p.details = `${p.occupation || ''}`.trim();
        } else if (p.type === 'COACHING') {
            p.program = `COACHING`.trim();
            p.details = `${p.course || ''} - ${p.batch || ''}`.trim();
        }
    }

    removeProgram(index: number) {
        this.suggestedPrograms.splice(index, 1);
        this.initializeMigrationData();
    }

    get allInterests(): any[] {
        const interests: any[] = [];
        if (!this.studentPrograms) return interests;

        (this.studentPrograms.study || []).forEach((p: any) => {
            interests.push({
                type: 'STUDY',
                country: p.country || '',
                level: p.level || '',
                field: p.field || '',
                timing: `${p.intake || ''} ${p.year || ''}`.trim()
            });
        });
        (this.studentPrograms.migration || []).forEach((p: any) => {
            interests.push({
                type: 'MIGRATION',
                country: p.country || '',
                level: p.occupation || '',
                field: p.category || '',
                timing: ''
            });
        });
        (this.studentPrograms.visa || []).forEach((p: any) => {
            interests.push({
                type: 'VISA',
                country: p.country || '',
                level: p.category || '',
                field: '',
                timing: ''
            });
        });
        (this.studentPrograms.work || []).forEach((p: any) => {
            interests.push({
                type: 'WORK',
                country: p.country || '',
                level: p.occupation || '',
                field: '',
                timing: ''
            });
        });
        (this.studentPrograms.coaching || []).forEach((p: any) => {
            interests.push({
                type: 'COACHING',
                country: '',
                level: p.course || '',
                field: p.batch || '',
                timing: ''
            });
        });

        return interests;
    }

    get showAgeField(): boolean {
        if (!this.suggestedPrograms || this.suggestedPrograms.length === 0) {
            return true;
        }
        const types = this.suggestedPrograms.map(p => (p.type || '').toUpperCase());
        const onlyVisa = types.every(t => t === 'VISA');
        return !onlyVisa;
    }

    get showGeneralWorkExperience(): boolean {
        if (!this.suggestedPrograms || this.suggestedPrograms.length === 0) {
            return true;
        }
        return !this.suggestedPrograms.some(p => (p.type || '').toUpperCase() === 'MIGRATION');
    }

    get migrationCountries(): string[] {
        const countries: string[] = [];
        
        // From Student Interests (Only MIGRATION)
        if (this.studentPrograms && this.studentPrograms.migration) {
            this.studentPrograms.migration.forEach((p: any) => {
                if (p.country) countries.push(p.country);
            });
        }

        // From Suggested Programs (Only MIGRATION)
        if (this.suggestedPrograms && this.suggestedPrograms.length > 0) {
            this.suggestedPrograms.forEach(p => {
                if (p.type === 'MIGRATION' && p.country) countries.push(p.country);
            });
        }
        
        return [...new Set(countries)].sort();
    }

    get interestedCountries(): string[] {
        const countries: string[] = [];
        
        // From Suggested Programs (Only STUDY and MIGRATION)
        this.suggestedPrograms.forEach(p => {
            if (p.country && (p.type === 'STUDY' || p.type === 'MIGRATION')) {
                countries.push(p.country);
            }
        });

        // From Student Interests (Only STUDY and MIGRATION)
        if (this.studentPrograms) {
            ['study', 'migration'].forEach(type => {
                (this.studentPrograms[type] || []).forEach((p: any) => {
                    if (p.country) countries.push(p.country);
                });
            });
        }
        
        return [...new Set(countries)].sort();
    }

    get educationCountries(): string[] {
        return this.interestedCountries;
    }

    initializeMigrationData() {
        if (!this.application.migration_data) this.application.migration_data = {};
        if (!this.application.migration_spouse_data) this.application.migration_spouse_data = {};
        if (!this.application.relatives_data) this.application.relatives_data = {};
        if (!this.application.education_data) this.application.education_data = { additional: [] };
        if (this.application.education_data.additional.length === 0) {
            this.addQualification();
        }

        if (!this.application.spouse_education) this.application.spouse_education = [];
        if (this.application.spouse_education.length === 0) {
            this.addSpouseQualification();
        }

        if (!this.application.work_experience_list) this.application.work_experience_list = [];
        if (!this.application.spouse_work_experience_list) this.application.spouse_work_experience_list = [];
        if (!this.application.relatives_list) this.application.relatives_list = [];

        // Pre-initialize Relatives Abroad toggle based on existing data
        if (this.application.relatives_list.length > 0) {
            this.application.has_relatives_abroad = true;
        }

        this.migrationCountries.forEach(country => {
            if (!this.application.migration_data[country]) {
                this.application.migration_data[country] = { 
                    has_edu: false, edu_level: '', edu_field: '', 
                    has_work: false, work_years: '', work_months: '', job_title: '', work_experience_list: [] 
                };
            }
            if (!this.application.migration_spouse_data[country]) {
                this.application.migration_spouse_data[country] = { 
                    has_edu: false, edu_level: '', edu_field: '', 
                    has_work: false, work_years: '', work_months: '', job_title: '', work_experience_list: [] 
                };
            }
        });
    }



    addSpouseQualification() {
        if (!this.application.spouse_education) {
            this.application.spouse_education = [];
        }
        this.application.spouse_education.push({ country: '', level: '', field: '', status: 'Completed', expected_completion: '' });
    }

    removeSpouseQualification(index: number) {
        if (this.application.spouse_education && this.application.spouse_education[index]) {
            this.application.spouse_education.splice(index, 1);
        }
    }

    addWorkExperience(country: string | null, target: string, subTarget: string = 'work_experience_list') {
        const newItem = { job_title: '', work_years: '', work_months: '', employment_country: '', status: 'Completed', start_date: '' };
        if (country) {
            if (!this.application[target][country][subTarget]) {
                this.application[target][country][subTarget] = [];
            }
            this.application[target][country][subTarget].push(newItem);
        } else {
            if (!this.application[target]) {
                this.application[target] = [];
            }
            this.application[target].push(newItem);
        }
    }

    removeWorkExperience(country: string | null, target: string, index: number, subTarget: string = 'work_experience_list') {
        if (country) {
            this.application[target][country][subTarget].splice(index, 1);
        } else {
            this.application[target].splice(index, 1);
        }
    }

    onWorkToggle(country: string | null, target: string, subTarget: string = 'work_experience_list') {
        const list = country ? this.application[target][country][subTarget] : this.application[target];
        const hasWork = country ? (subTarget === 'current_work_experience_list' ? this.application[target][country].is_currently_working : this.application[target][country].has_other_work) : 
                       (target === 'work_experience_list' ? this.application.has_work_experience : this.application.spouse_has_work_experience);

        if (hasWork && (!list || list.length === 0)) {
            this.addWorkExperience(country, target, subTarget);
        } else if (!hasWork) {
            if (country) this.application[target][country][subTarget] = [];
            else this.application[target] = [];
        }
    }

    addRelative() {
        if (!this.application.relatives_list) this.application.relatives_list = [];
        this.application.relatives_list.push({ country: '', relationship: '', related_to: 'Applicant' });
    }

    removeRelative(index: number) {
        this.application.relatives_list.splice(index, 1);
    }

    onRelativesToggle() {
        if (this.application.has_relatives_abroad && (!this.application.relatives_list || this.application.relatives_list.length === 0)) {
            this.addRelative();
        } else if (!this.application.has_relatives_abroad) {
            this.application.relatives_list = [];
        }
    }

    addQualification() {
        if (!this.application.education_data.additional) {
            this.application.education_data.additional = [];
        }
        this.application.education_data.additional.push({ country: '', level: '', field: '', status: 'Completed', expected_completion: '' });
    }

    removeQualification(index: number) {
        this.application.education_data.additional.splice(index, 1);
    }

    clearHighestQualification() {
        this.application.education_country = '';
        this.application.highest_education = '';
        this.application.education_field = '';
        this.application.highest_education_status = 'Completed';
        this.application.highest_education_expected = '';
    }


    addLanguageTest(target: 'application' | 'spouse' = 'application') {
        const listKey = target === 'spouse' ? 'spouse_language_test_list' : 'language_test_list';
        if (!this.application[listKey]) this.application[listKey] = [];
        this.application[listKey].push({
            type: '',
            reading: '',
            listening: '',
            speaking: '',
            writing: ''
        });
    }

    removeLanguageTest(index: number, target: 'application' | 'spouse' = 'application') {
        const listKey = target === 'spouse' ? 'spouse_language_test_list' : 'language_test_list';
        this.application[listKey].splice(index, 1);
    }

    addAdmissionTest() {
        if (!this.application.admission_test_list) this.application.admission_test_list = [];
        this.application.admission_test_list.push({
            type: '',
            quant: '',
            verbal: '',
            data_insights: ''
        });
    }

    removeAdmissionTest(index: number) {
        this.application.admission_test_list.splice(index, 1);
    }

    onTestToggle(type: 'language' | 'admission', target: 'application' | 'spouse' = 'application') {
        if (type === 'language') {
            const hasKey = target === 'spouse' ? 'spouse_has_language_test' : 'has_language_test';
            const listKey = target === 'spouse' ? 'spouse_language_test_list' : 'language_test_list';
            if (this.application[hasKey] && (!this.application[listKey] || this.application[listKey].length === 0)) {
                this.addLanguageTest(target);
            }
        } else {
            if (this.application.has_admission_test && (!this.application.admission_test_list || this.application.admission_test_list.length === 0)) {
                this.addAdmissionTest();
            }
        }
    }

    shouldShowExpCompletion(primaryStatus: string, additionalRows: any[] = []): boolean {
        if (primaryStatus === 'Not Completed') return true;
        if (additionalRows && additionalRows.length > 0) {
            return additionalRows.some(r => r.status === 'Not Completed');
        }
        return false;
    }

    shouldShowListExpCompletion(rows: any[]): boolean {
        if (!rows || rows.length === 0) return false;
        return rows.some(r => r.status === 'Not Completed');
    }

    hasInterest(type: 'study' | 'migration' | 'visa' | 'work' | 'coaching'): boolean {
        return !!(this.studentPrograms && this.studentPrograms[type] && this.studentPrograms[type].length > 0);
    }


    forceSyncPrograms() {
        if (confirm('This will overwrite current suggested programs. Continue?')) {
            this.suggestedPrograms = [];
            this.syncSuggestedPrograms();
        }
    }

    syncSuggestedPrograms() {
        if (!this.studentPrograms || this.suggestedPrograms.length > 0) return;

        const interests: any[] = [];
        (this.studentPrograms.study || []).forEach((p: any) => {
            const common = {
                type: 'STUDY',
                program: `STUDY ${p.country || ''}`.trim(),
                status: '',
                sub_status: '',
                remarks: '',
                is_selected: true,
                branch_id: null,
                department_id: null,
                assigned_to: null,
                country: p.country || '',
                level: p.level || '',
                field: p.field || '',
                intake: p.intake || '',
                year: p.year || ''
            };
            interests.push({ ...common, subType: 'default', details: `${p.level || ''} ${p.field || ''} - ${p.intake || ''} ${p.year || ''}`.trim() });
        });
        (this.studentPrograms.migration || []).forEach((p: any) => {
            interests.push({
                type: 'MIGRATION',
                subType: 'default',
                program: `${p.country || ''}`,
                details: `${p.occupation || ''} - ${p.category || ''}`,
                status: '',
                sub_status: '',
                remarks: '',
                is_selected: true,
                country: p.country || '',
                occupation: p.occupation || '',
                category: p.category || ''
            });
        });
        (this.studentPrograms.visa || []).forEach((p: any) => {
            interests.push({
                type: 'VISA',
                subType: 'default',
                program: `${p.country || ''}`,
                details: `${p.category || ''}`,
                status: '',
                sub_status: '',
                remarks: '',
                is_selected: true,
                country: p.country || '',
                category: p.category || ''
            });
        });
        (this.studentPrograms.work || []).forEach((p: any) => {
            interests.push({
                type: 'WORK',
                subType: 'default',
                program: `${p.country || ''}`,
                details: `${p.occupation || ''}`,
                status: '',
                sub_status: '',
                remarks: '',
                is_selected: true,
                country: p.country || '',
                occupation: p.occupation || ''
            });
        });
        (this.studentPrograms.coaching || []).forEach((p: any) => {
            interests.push({
                type: 'COACHING',
                subType: 'default',
                program: `COACHING`,
                details: `${p.course || ''} - ${p.batch || ''}`,
                status: '',
                sub_status: '',
                remarks: '',
                is_selected: true,
                course: p.course || '',
                batch: p.batch || ''
            });
        });

        this.suggestedPrograms = interests;
    }

    hasCountryInterest(countryName: string): boolean {
        // Check in suggested programs table
        if (this.suggestedPrograms && this.suggestedPrograms.length > 0) {
            return this.suggestedPrograms.some(p => p.country === countryName);
        }

        // Fallback to student profile data
        if (!this.studentPrograms) return false;
        const study = this.studentPrograms.study || [];
        const migration = this.studentPrograms.migration || [];
        const visa = this.studentPrograms.visa || [];
        const work = this.studentPrograms.work || [];

        return study.some((p: any) => p.country === countryName) ||
            migration.some((p: any) => p.country === countryName) ||
            visa.some((p: any) => p.country === countryName) ||
            work.some((p: any) => p.country === countryName);
    }

    onSave() {
        // Sync UI phone-code dropdowns → backend field names before saving
        if (this.application.mobile_country_code) this.application.contact1_code = this.application.mobile_country_code;
        if (this.application.phone_country_code)  this.application.contact2_code = this.application.phone_country_code;

        // Sync JSON data back to flat fields for hardcoded countries (Backward Compatibility)
        const countriesToSync = [
            { name: 'Canada', prefix: 'canadian' },
            { name: 'Australia', prefix: 'australian' },
            { name: 'New Zealand', prefix: 'nz' }
        ];

        countriesToSync.forEach(c => {
            const prefix = c.prefix;
            const name = c.name;

            // Sync Education
            if (this.application.education_data[name]) {
                this.application[`has_${prefix}_edu`] = this.application.education_data[name].has_edu;
                this.application[`${prefix}_edu_level`] = this.application.education_data[name].level;
                this.application[`${prefix}_edu_field`] = this.application.education_data[name].field;
            }

            // Sync Work Years (using migration_data for work years as unified source)
            if (this.application.migration_data[name]) {
                this.application[`${prefix}_work_years`] = this.application.migration_data[name].work_years;
            }

            // Sync Spouse fields
            if (this.application.migration_spouse_data[name]) {
                this.application[`spouse_${prefix}_edu`] = this.application.migration_spouse_data[name].has_edu;
                this.application[`spouse_${prefix}_work`] = this.application.migration_spouse_data[name].work_years;
            }
        });
        
        // Map UI-only work properties into migration_data JSON for saving
        if (!this.application.migration_data) this.application.migration_data = {};
        if (!this.application.migration_data['General']) this.application.migration_data['General'] = {};
        this.application.migration_data['General'].work_experience_list = this.application.has_work_experience ? this.application.work_experience_list : [];
        this.application.migration_data['General'].has_other_work_experience = this.application.has_other_work_experience;
        this.application.migration_data['General'].other_work_experience_list = this.application.has_other_work_experience ? this.application.other_work_experience_list : [];
        
        // Map UI-only test properties into education_data JSON for saving
        if (!this.application.education_data) this.application.education_data = { additional: [] };
        this.application.education_data.language_test_list = this.application.has_language_test ? this.application.language_test_list : [];
        this.application.education_data.spouse_has_language_test = this.application.spouse_has_language_test;
        this.application.education_data.spouse_language_test_list = this.application.spouse_has_language_test ? this.application.spouse_language_test_list : [];
        this.application.education_data.admission_test_list = this.application.has_admission_test ? this.application.admission_test_list : [];
        this.application.education_data.highest_education_status = this.application.highest_education_status;
        this.application.education_data.highest_education_expected = this.application.highest_education_expected;
        this.application.education_data.education_country = this.application.education_country;
        this.application.education_data.spouse_edu_country = this.application.spouse_edu_country;
        this.application.education_data.spouse_edu_field = this.application.spouse_edu_field;
        this.application.education_data.spouse_education = this.application.spouse_education;
        
        // Validate children if any
        if (this.children && this.children.length > 0) {
            const invalidChild = this.children.find(c => c.age === null || c.age === undefined || c.is_accompanying === null || c.is_accompanying === undefined);
            if (invalidChild) {
                this.dialogService.error('Please provide Age and Accompanying status for all children.');
                setTimeout(() => {
                    const el = document.getElementById('childrenSection');
                    if (el) el.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }, 100);
                return;
            }
        }

        // --- Transformations for Strict Relational Backend ---
        const education_list: any[] = [];
        const work_experience_list: any[] = [];
        const language_tests: any[] = [];
        const admission_tests = this.application.admission_test_list || [];
        const relatives: any[] = [];

        // Gather Language Tests (Applicant + Spouse)
        if (this.application.language_test_list) {
            this.application.language_test_list.forEach((t: any) => {
                language_tests.push({ ...t, is_spouse: 0 });
            });
        }
        if (this.application.spouse_language_test_list) {
            this.application.spouse_language_test_list.forEach((t: any) => {
                language_tests.push({ ...t, is_spouse: 1 });
            });
        }

        // 1. Gather Education
        if (this.application.education_data) {
            Object.keys(this.application.education_data).forEach(country => {
                if (country === 'additional') {
                    // Highest/Current Study additional rows
                    const additional = this.application.education_data[country];
                    if (Array.isArray(additional)) {
                        additional.forEach((q: any, idx: number) => {
                            education_list.push({
                                country: q.country || '',
                                level: q.level,
                                field: q.field,
                                status: q.status || 'Completed',
                                expected_completion: q.expected_completion || null,
                                edu_type: 'highest',
                                is_highest: idx === 0 ? 1 : 0
                            });
                        });
                    }
                    return;
                }
                
                const edu = this.application.education_data[country];
                if (edu && edu.has_edu) {
                    // Primary Entry for fixed countries (Australia/Canada/etc)
                    education_list.push({
                        country: country,
                        level: edu.level,
                        field: edu.field,
                        status: edu.status || 'Completed',
                        expected_completion: edu.expected_completion || null,
                        edu_type: 'country',
                        is_highest: 0
                    });
                    
                    // Additional Entries for this fixed country
                    if (edu.additional_entries && edu.additional_entries.length > 0) {
                        edu.additional_entries.forEach((ae: any) => {
                            education_list.push({
                                country: ae.country || country,
                                level: ae.level,
                                field: ae.field,
                                status: ae.status || 'Completed',
                                expected_completion: ae.expected_completion || null,
                                edu_type: 'country',
                                is_highest: 0
                            });
                        });
                    }
                }
            });
        }


        // --- Spouse Education Gathering ---
        const spouse_education: any[] = [];
        // 1. Fixed Countries Spouse Education
        if (this.application.migration_spouse_data) {
            this.migrationCountries.forEach(country => {
                const edu = this.application.migration_spouse_data[country];
                if (edu && edu.has_edu) {
                    spouse_education.push({
                        country: country,
                        level: edu.edu_level,
                        field: edu.edu_field,
                        status: edu.status || 'Completed',
                        expected_completion: edu.expected_completion || null,
                        edu_type: 'country'
                    });
                    if (edu.additional_entries) {
                        edu.additional_entries.forEach((ae: any) => {
                            spouse_education.push({
                                country: country,
                                level: ae.level,
                                field: ae.field,
                                status: ae.status || 'Completed',
                                expected_completion: ae.expected_completion || null,
                                edu_type: 'country'
                            });
                        });
                    }
                }
            });
        }
        // 2. Highest Education Spouse
        if (this.application.spouse_edu_level) {
            spouse_education.push({
                country: this.application.spouse_edu_country || '',
                level: this.application.spouse_edu_level,
                field: this.application.spouse_edu_field,
                status: this.application.spouse_edu_status || 'Completed',
                expected_completion: this.application.spouse_edu_expected || null,
                edu_type: 'highest'
            });
        }
        if (this.application.spouse_education) {
            this.application.spouse_education.forEach((q: any) => {
                spouse_education.push({
                    country: q.country || '',
                    level: q.level,
                    field: q.field,
                    status: q.status || 'Completed',
                    expected_completion: q.expected_completion || null,
                    edu_type: 'highest'
                });
            });
        }
        // 3. Other Country Spouse Education
        if (this.application.spouse_has_other_country_edu && this.application.spouse_other_country_edu_list) {
            this.application.spouse_other_country_edu_list.forEach((edu: any) => {
                spouse_education.push({
                    country: edu.country || 'Other',
                    level: edu.level,
                    field: edu.field,
                    status: edu.status || 'Completed',
                    expected_completion: edu.expected_completion || null,
                    edu_type: 'other'
                });
            });
        }

        // 2. Gather Work Experience (Only if job_title is present)
        if (this.application.has_work_experience && this.application.work_experience_list) {
            this.application.work_experience_list.forEach((w: any) => {
                if (w.job_title) {
                    work_experience_list.push({
                        country: w.country || w.employment_country || 'General',
                        job_title: w.job_title,
                        status: w.status || 'Completed',
                        start_date: w.start_date || null,
                        work_years: parseInt(w.work_years) || 0,
                        work_months: parseInt(w.work_months) || 0,
                        type: 'current',
                        work_type: 'curr_other'
                    });
                }
            });
        }

        if (this.application.has_other_work_experience && this.application.other_work_experience_list) {
            this.application.other_work_experience_list.forEach((w: any) => {
                if (w.job_title) {
                    work_experience_list.push({
                        country: w.country || w.employment_country || 'General',
                        job_title: w.job_title,
                        status: w.status || 'Completed',
                        start_date: w.start_date || null,
                        work_years: parseInt(w.work_years) || 0,
                        work_months: parseInt(w.work_months) || 0,
                        type: 'previous',
                        work_type: 'curr_other'
                    });
                }
            });
        }

        if (this.application.migration_data) {
            this.migrationCountries.forEach(country => {
                const mig = this.application.migration_data[country];
                if (mig && mig.work_experience_list) {
                    mig.work_experience_list.forEach((w: any) => {
                        if (w.job_title) {
                            work_experience_list.push({
                                country: country,
                                job_title: w.job_title,
                                status: w.status || 'Completed',
                                start_date: w.start_date || null,
                                work_years: parseInt(w.work_years) || 0,
                                work_months: parseInt(w.work_months) || 0,
                                type: 'current',
                                work_type: 'curr_country'
                            });
                        }
                    });
                }
            });
        }

        // --- Spouse Work Gathering ---
        const spouse_work: any[] = [];
        // 1. General Spouse Work
        if (this.application.spouse_has_work_experience && this.application.spouse_work_experience_list) {
            this.application.spouse_work_experience_list.forEach((w: any) => {
                if (w.job_title) {
                    spouse_work.push({
                        country: w.employment_country || 'General',
                        job_title: w.job_title,
                        status: w.status || 'Completed',
                        start_date: w.start_date || null,
                        work_years: parseInt(w.work_years) || 0,
                        work_months: parseInt(w.work_months) || 0,
                        work_type: 'curr_other'
                    });
                }
            });
        }
        // 2. Fixed Country Spouse Work
        if (this.application.migration_spouse_data) {
            this.migrationCountries.forEach(country => {
                const mig = this.application.migration_spouse_data[country];
                if (mig && mig.has_work) {
                    if (mig.is_currently_working && mig.current_work_experience_list) {
                        mig.current_work_experience_list.forEach((w: any) => {
                            if (w.job_title) {
                                spouse_work.push({
                                    country: country,
                                    job_title: w.job_title,
                                    status: w.status || 'Completed',
                                    start_date: w.start_date || null,
                                    work_years: parseInt(w.work_years) || 0,
                                    work_months: parseInt(w.work_months) || 0,
                                    work_type: 'curr_country'
                                });
                            }
                        });
                    }
                    if (mig.has_other_work && mig.other_work_experience_list) {
                        mig.other_work_experience_list.forEach((w: any) => {
                            if (w.job_title) {
                                spouse_work.push({
                                    country: country,
                                    job_title: w.job_title,
                                    status: w.status || 'Completed',
                                    start_date: w.start_date || null,
                                    work_years: parseInt(w.work_years) || 0,
                                    work_months: parseInt(w.work_months) || 0,
                                    work_type: 'other_country'
                                });
                            }
                        });
                    }
                }
            });
        }

        // 3. Gather Relatives
        if (this.application.has_relatives_abroad && this.application.relatives_list) {
            this.application.relatives_list.forEach((rel: any) => {
                if (rel.country) {
                    relatives.push({
                        country: rel.country,
                        relationship: rel.relationship,
                        related_to: rel.related_to || 'Applicant'
                    });
                }
            });
        }

        const data = {
            application: this.application,
            children: this.children,
            suggestedPrograms: this.suggestedPrograms,
            education_list,
            work_experience_list,
            language_tests,
            admission_tests,
            spouse_education,
            spouse_work,
            relatives,
            skill_assessment_list: this.application.skill_assessment_list || []
        };

        this.loadingService.show();
        this.studentService.saveStudentRegistration(this.studentId, data).subscribe({
            next: () => {
                this.loadingService.hide();
                this.dialogService.success('Registration saved successfully');
            },
            error: (err) => {
                this.loadingService.hide();
                this.dialogService.error('Error saving registration: ' + err.message);
            }
        });
    }

    onDobChange() {
        if (!this.application.dob) {
            this.application.age = null;
            return;
        }
        const birthDate = new Date(this.application.dob);
        const today = new Date();
        let age = today.getFullYear() - birthDate.getFullYear();
        const m = today.getMonth() - birthDate.getMonth();
        if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
            age--;
        }
        this.application.age = age < 0 ? 0 : age;
    }

    patchFromAssessment(data: any) {
        if (!data || !data.application) return;
        const app: any = data.application;
        const regApp: any = this.application;

        // ─── Scalar Fields ─────────────────────────────────────────────────────────
        // When this is a NEW registration (no saved data), copy ALL assessment fields.
        // When editing an existing registration, only fill genuinely empty fields.
        const isNew = !this.registrationLoaded;

        const scalarFields = [
            'passport_name', 'first_name', 'last_name', 'gender', 'marital_status',
            'spouse_accompanying', 'spouse_age', 'dob', 'age',
            'address_country', 'address_state', 'address_suburb', 'address_postcode',
            'contact1', 'contact1_code', 'contact2', 'contact2_code', 'email',
            'citizenship_country', 'passport_country', 'has_second_passport', 'second_passport_country',
            'education_country', 'highest_education', 'education_field',
            'highest_education_status', 'highest_education_expected',
            'has_canadian_edu', 'canadian_edu_level', 'canadian_edu_field',
            'has_australian_edu', 'australian_edu_level', 'australian_edu_field',
            'has_aus_specialised_edu', 'aus_specialised_edu_level', 'aus_specialised_edu_field',
            'has_nz_edu', 'nz_edu_level', 'nz_edu_field',
            'has_work_experience', 'total_work_experience',
            'canadian_work_years', 'australian_work_years', 'nz_work_years',
            'has_other_work_experience',
            'has_language_test', 'language_test_type',
            'reading_score', 'listening_score', 'speaking_score', 'writing_score',
            'has_admission_test', 'admission_test_type',
            'quant_score', 'verbal_score', 'data_insights_score',
            'has_relatives',
            'spouse_edu_country', 'spouse_edu_level', 'spouse_edu_field',
            'spouse_edu_status', 'spouse_edu_expected',
            'spouse_has_work_experience', 'spouse_has_other_work_experience',
            'spouse_work_experience_years',
            'spouse_has_language_test', 'spouse_lang_test_type',
            'spouse_writing', 'spouse_listening', 'spouse_speaking', 'spouse_reading',
            'spouse_canadian_edu', 'spouse_canadian_edu_level', 'spouse_canadian_edu_field',
            'spouse_australian_edu', 'spouse_australian_edu_level', 'spouse_australian_edu_field',
            'spouse_aus_specialised_edu', 'spouse_aus_specialised_edu_level', 'spouse_aus_specialised_edu_field',
            'contact1_whatsapp', 'contact1_bot', 'contact1_telegram',
            'contact2_whatsapp', 'contact2_bot', 'contact2_telegram',
            'has_language_interest', 'has_admission_interest',
            'interested_in_lang_coaching', 'lang_coaching_course', 'expected_lang_coaching_date',
            'interested_in_admission_coaching', 'admission_coaching_course', 'expected_admission_coaching_date',
            'has_skill_assessment', 'skill_assessment_interest'
        ];

        scalarFields.forEach(field => {
            if (app[field] === undefined || app[field] === null) return;
            const currentVal = regApp[field];
            const isEmpty = currentVal === '' || currentVal === null || currentVal === undefined || currentVal === false || currentVal === 0;
            if (isNew || isEmpty) {
                let value = app[field];
                
                // Force boolean conversion for checkboxes/dropdowns
                const booleanFields = [
                    'spouse_accompanying', 'has_canadian_edu', 'has_australian_edu', 'has_aus_specialised_edu',
                    'has_nz_edu', 'has_work_experience', 'has_other_work_experience', 'has_language_test', 
                    'has_admission_test', 'has_relatives', 'spouse_canadian_edu', 'spouse_australian_edu', 
                    'spouse_aus_specialised_edu', 'has_second_passport', 'spouse_has_work_experience',
                    'spouse_has_other_work_experience', 'spouse_has_language_test', 'has_skill_assessment',
                    'skill_assessment_interest',
                    'contact1_whatsapp', 'contact1_bot', 'contact1_telegram',
                    'contact2_whatsapp', 'contact2_bot', 'contact2_telegram',
                    'has_language_interest', 'has_admission_interest',
                    'interested_in_lang_coaching', 'interested_in_admission_coaching',
                    'has_skill_assessment', 'skill_assessment_interest'
                ];
                if (booleanFields.includes(field)) {
                    value = value === null ? null : !!value;
                }

                // Format DOB for date input
                if (field === 'dob' && value) {
                    try {
                        if (value.includes('T')) {
                            const d = new Date(value);
                            value = `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`;
                        }
                    } catch (e) { }
                }
                regApp[field] = value;
            }
        });

        // Default passport country to citizenship country if empty
        if (!regApp.passport_country && app.citizenship_country) {
            regApp.passport_country = app.citizenship_country;
        }

        // ─── Contact Codes (always sync from assessment) ───────────────────────────
        if (app.contact1_code) regApp.mobile_country_code = app.contact1_code;
        if (app.contact2_code) regApp.phone_country_code = app.contact2_code;

        // ─── Age from DOB ─────────────────────────────────────────────────────────
        if (regApp.dob) this.onDobChange();

        // ─── Ensure relational containers exist ───────────────────────────────────
        if (!regApp.education_data || typeof regApp.education_data !== 'object') regApp.education_data = { additional: [] };
        if (!regApp.migration_data || typeof regApp.migration_data !== 'object') regApp.migration_data = {};
        if (!regApp.migration_spouse_data || typeof regApp.migration_spouse_data !== 'object') regApp.migration_spouse_data = {};
        if (!regApp.relatives_data || typeof regApp.relatives_data !== 'object') regApp.relatives_data = {};

        // ─── Language / Admission Tests ────────────────────────────────────────────
        // Copy from assessment relational list when registration has none
        const assessLangTests: any[] = (data.language_tests || []).filter((t: any) => !t.is_spouse);
        const assessSpouseLangTests: any[] = (data.language_tests || []).filter((t: any) => t.is_spouse);
        const assessAdmTests: any[] = data.admission_tests || [];

        // ─── Language Tests ───────────────────────────────────────────────────────
        if (assessLangTests.length > 0) {
            regApp.language_test_list = assessLangTests.map((t: any) => {
                const testType = String(t.test_type || t.type || t.language_test || t.testType || '').trim().toUpperCase();
                return {
                    test_type: testType,
                    type: testType,
                    reading: t.reading || t.reading_score || '',
                    writing: t.writing || t.writing_score || '',
                    speaking: t.speaking || t.speaking_score || '',
                    listening: t.listening || t.listening_score || '',
                    overall: t.overall || '',
                    is_spouse: 0
                };
            });
        } else if (app.has_language_test && app.language_test_type) {
            // Legacy flat-field fallback
            regApp.language_test_list = [{
                test_type: String(app.language_test_type).trim().toUpperCase(),
                type: String(app.language_test_type).trim().toUpperCase(),
                reading: app.reading_score || '',
                writing: app.writing_score || '',
                speaking: app.speaking_score || '',
                listening: app.listening_score || '',
                overall: '',
                is_spouse: 0
            }];
        }

        // Force boolean visibility if records exist
        if (regApp.language_test_list && regApp.language_test_list.length > 0) {
            regApp.has_language_test = true;
        }

        // ─── Spouse Language Tests ───────────────────────────────────────────────
        if (assessSpouseLangTests.length > 0) {
            regApp.spouse_language_test_list = assessSpouseLangTests.map((t: any) => {
                const testType = String(t.test_type || t.type || t.language_test || t.testType || '').trim().toUpperCase();
                return {
                    test_type: testType,
                    type: testType,
                    reading: t.reading || t.reading_score || '',
                    writing: t.writing || t.writing_score || '',
                    speaking: t.speaking || t.speaking_score || '',
                    listening: t.listening || t.listening_score || '',
                    overall: t.overall || '',
                    is_spouse: 1
                };
            });
            regApp.spouse_lang_test_type = regApp.spouse_language_test_list[0]?.type || '';
        }

        // Force boolean visibility if records exist
        if (regApp.spouse_language_test_list && regApp.spouse_language_test_list.length > 0) {
            regApp.spouse_has_language_test = true;
        }

        // ─── Admission Tests ──────────────────────────────────────────────────────
        if (!regApp.admission_test_list || regApp.admission_test_list.length === 0) {
            if (assessAdmTests.length > 0) {
                regApp.admission_test_list = assessAdmTests.map((t: any) => ({
                    test_type: t.type || t.test_type || '',
                    type: t.type || t.test_type || '',
                    quant: t.quant || t.quant_score || '',
                    verbal: t.verbal || t.verbal_score || '',
                    data_insights: t.data_insights || t.data_insights_score || '',
                    overall: t.overall || ''
                }));
            } else if (app.has_admission_test && app.admission_test_type) {
                regApp.admission_test_list = [{
                    test_type: app.admission_test_type || '',
                    type: app.admission_test_type || '',
                    quant: app.quant_score || '',
                    verbal: app.verbal_score || '',
                    data_insights: app.data_insights_score || '',
                    overall: ''
                }];
            }
        }
        // Force boolean visibility if records exist
        if (regApp.admission_test_list && regApp.admission_test_list.length > 0) {
            regApp.has_admission_test = true;
        }

        // ─── Relational Data (Education, Work, Spouse, Relatives) ─────────────────
        if (isNew) {
            this.mapRelationalData(data);
        }

        // Always patch skill assessment list if current registration has none
        const assessSkillList = data.skill_assessment_list || app.skill_assessment_list;
        if (isNew || !regApp.skill_assessment_list || regApp.skill_assessment_list.length === 0) {
            if (assessSkillList && assessSkillList.length > 0) {
                regApp.skill_assessment_list = JSON.parse(JSON.stringify(assessSkillList));
            }
        }

        // ─── Children ─────────────────────────────────────────────────────────────
        if ((isNew || !this.children || this.children.length === 0) && data.children && data.children.length > 0) {
            this.children = data.children.map((c: any) => ({ ...c, is_accompanying: !!c.is_accompanying }));
            regApp.has_children = true;
        }

        // ─── Suggested Programs ───────────────────────────────────────────────────
        if ((isNew || !this.suggestedPrograms || this.suggestedPrograms.length === 0) && data.suggestedPrograms && data.suggestedPrograms.length > 0) {
            this.suggestedPrograms = this.parseSuggestedPrograms(JSON.parse(JSON.stringify(data.suggestedPrograms)));
            this.suggestedPrograms.forEach((p: any, i: number) => {
                if (p.branch_id) this.loadRowDepartments(i, p.branch_id);
                if (p.branch_id && p.department_id) this.loadRowStaff(i, p.branch_id, p.department_id);
            });
        }

        // ─── Coaching Interests ───────────────────────────────────────────────────
        if (isNew) {
            if (data.lang_interest && data.lang_interest.length > 0) {
                regApp.interested_in_lang_coaching = true;
                regApp.lang_coaching_course = data.lang_interest[0].course;
                regApp.expected_lang_coaching_date = data.lang_interest[0].expected_date ? data.lang_interest[0].expected_date.substring(0, 10) : '';
            }
            if (data.spouse_lang_interest && data.spouse_lang_interest.length > 0) {
                regApp.spouse_interested_in_lang_coaching = true;
                regApp.spouse_lang_coaching_course = data.spouse_lang_interest[0].course;
                regApp.spouse_expected_lang_coaching_date = data.spouse_lang_interest[0].expected_date ? data.spouse_lang_interest[0].expected_date.substring(0, 10) : '';
            }
            if (data.adm_interest && data.adm_interest.length > 0) {
                regApp.interested_in_admission_coaching = true;
                regApp.admission_coaching_course = data.adm_interest[0].course;
                regApp.expected_admission_coaching_date = data.adm_interest[0].expected_date ? data.adm_interest[0].expected_date.substring(0, 10) : '';
            }
        }

        // ─── Final cleanup ────────────────────────────────────────────────────────
        this.initializeMigrationData();
        this.prePopulateFields();
    }

    mapRelationalData(data: any) {
        if (!data) return;
        const app: any = this.application;
        const formatMonth = (d: string) => d ? d.substring(0, 7) : '';

        // ── Education list ────────────────────────────────────────────────────────
        if (data.education_list && data.education_list.length > 0) {
            if (!app.education_data || typeof app.education_data !== 'object') {
                app.education_data = { additional: [] };
            }
            if (!Array.isArray(app.education_data.additional)) {
                app.education_data.additional = [];
            }
            
            // Clear current list to avoid duplicates on reload
            app.education_data.additional = [];
            this.migrationCountries.forEach((c: string) => {
                if (app.education_data[c]) app.education_data[c].additional_entries = [];
            });
            app.other_country_edu_list = [];

            data.education_list.forEach((edu: any) => {
                if (edu.is_highest || edu.edu_type === 'highest') {
                    if (edu.is_highest) {
                        app.highest_education = edu.level;
                        app.education_field = edu.field;
                        app.education_country = edu.country;
                        app.highest_education_status = edu.status;
                        app.highest_education_expected = formatMonth(edu.expected_completion);
                    }
                    
                    // Always add to tabular list for registration view
                    if (!app.education_data.additional) app.education_data.additional = [];
                    app.education_data.additional.push({
                        ...edu,
                        expected_completion: formatMonth(edu.expected_completion)
                    });
                } else if (edu.edu_type === 'country') {
                    const country = edu.country;
                    if (!app.education_data[country]) {
                        app.education_data[country] = {
                            has_edu: true,
                            level: edu.level,
                            field: edu.field,
                            status: edu.status,
                            expected_completion: formatMonth(edu.expected_completion),
                            additional_entries: []
                        };
                    } else {
                        if (!app.education_data[country].additional_entries) app.education_data[country].additional_entries = [];
                        app.education_data[country].additional_entries.push({
                            ...edu,
                            expected_completion: formatMonth(edu.expected_completion)
                        });
                    }
                } else if (edu.edu_type === 'other') {
                    app.has_other_country_edu = true;
                    if (!app.other_country_edu_list) app.other_country_edu_list = [];
                    app.other_country_edu_list.push({
                        ...edu,
                        expected_completion: formatMonth(edu.expected_completion)
                    });
                }
            });
        }

        // ── Work experience list ──────────────────────────────────────────────────
        if (data.work_experience_list && data.work_experience_list.length > 0) {
            app.work_experience_list = [];
            app.other_work_experience_list = [];

            data.work_experience_list.forEach((w: any) => {
                w.start_date = w.start_date ? w.start_date.substring(0, 10) : '';
                const country = (w.country || '').trim();

                if (w.work_type === 'curr_country' || w.work_type === 'other_country') {
                    if (!app.migration_data[country]) {
                        app.migration_data[country] = {
                            has_edu: false, is_currently_working: false, has_other_work: false,
                            current_work_experience_list: [], other_work_experience_list: [],
                            additional_entries: []
                        };
                    }
                    app.migration_data[country].has_work = true;
                    app.has_work_experience = true;

                    if (w.work_type === 'curr_country') {
                        app.migration_data[country].is_currently_working = true;
                        if (!app.migration_data[country].current_work_experience_list) app.migration_data[country].current_work_experience_list = [];
                        app.migration_data[country].current_work_experience_list.push(w);
                    } else {
                        app.migration_data[country].has_other_work = true;
                        if (!app.migration_data[country].other_work_experience_list) app.migration_data[country].other_work_experience_list = [];
                        app.migration_data[country].other_work_experience_list.push(w);
                    }
                    
                    if (!app.work_experience_list) app.work_experience_list = [];
                    if (w.country && !w.employment_country) w.employment_country = w.country;
                    app.work_experience_list.push(w);

                } else if (w.work_type === 'other' || w.work_type === 'curr_other' || w.work_type === 'prev_other') {
                    app.has_work_experience = true;
                    const isCurrent = w.type === 'current' || w.is_current === 1 || w.is_current === true;
                    
                    if (!app.work_experience_list) app.work_experience_list = [];
                    if (w.country && !w.employment_country) w.employment_country = w.country;
                    app.work_experience_list.push(w);
                    
                    if (!isCurrent) {
                        app.has_other_work_experience = true;
                        if (!app.other_work_experience_list) app.other_work_experience_list = [];
                        app.other_work_experience_list.push(w);
                    }
                }
            });
            // Force boolean visibility if records exist
            if (app.work_experience_list?.length > 0 || app.other_work_experience_list?.length > 0) {
                app.has_work_experience = true;
            }
        }
        
        // Final safety check for toggles
        if (app.education_data?.additional?.length > 0) {
            // Logic to ensure main education fields are set if empty
            if (!app.highest_education && app.education_data.additional[0]) {
                const first = app.education_data.additional[0];
                app.highest_education = first.level;
                app.education_field = first.field;
                app.education_country = first.country;
                app.highest_education_status = first.status;
                app.highest_education_expected = first.expected_completion;
            }
        }
        if (app.work_experience_list?.length > 0) {
            app.has_work_experience = true;
        }

        // ── Spouse education ──────────────────────────────────────────────────────
        if (data.spouse_education && data.spouse_education.length > 0) {
            // Reset
            app.spouse_education = [];
            this.migrationCountries.forEach((c: string) => {
                if (app.migration_spouse_data && app.migration_spouse_data[c]) {
                    app.migration_spouse_data[c].additional_entries = [];
                }
            });

            data.spouse_education.forEach((edu: any) => {
                const formattedEdu = {
                    ...edu,
                    expected_completion: formatMonth(edu.expected_completion)
                };

                if (edu.edu_type === 'highest') {
                    if (!app.spouse_edu_country) {
                        app.spouse_edu_country = edu.country;
                        app.spouse_edu_level = edu.level;
                        app.spouse_edu_field = edu.field;
                        app.spouse_edu_status = edu.status;
                        app.spouse_edu_expected = formatMonth(edu.expected_completion);
                    } else {
                        if (!app.spouse_education) app.spouse_education = [];
                        app.spouse_education.push(formattedEdu);
                    }
                } else if (edu.edu_type === 'country') {
                    const country = (edu.country || '').trim();
                    if (!app.migration_spouse_data[country]) {
                        app.migration_spouse_data[country] = {
                            has_edu: true, is_currently_working: false, has_other_work: false,
                            current_work_experience_list: [], other_work_experience_list: [],
                            additional_entries: []
                        };
                    }
                    const sData = app.migration_spouse_data[country];
                    sData.has_edu = true;
                    if (!sData.edu_level) {
                        sData.edu_level = edu.level;
                        sData.edu_field = edu.field;
                        sData.status = edu.status;
                        sData.expected_completion = formatMonth(edu.expected_completion);
                    } else {
                        if (!sData.additional_entries) sData.additional_entries = [];
                        sData.additional_entries.push(formattedEdu);
                    }
                } else if (edu.edu_type === 'other') {
                    app.spouse_has_other_country_edu = true;
                    if (!app.spouse_other_country_edu_list) app.spouse_other_country_edu_list = [];
                    app.spouse_other_country_edu_list.push(formattedEdu);
                }
            });
        }

        // ── Spouse work ───────────────────────────────────────────────────────────
        if (data.spouse_work && data.spouse_work.length > 0) {
            app.spouse_work_experience_list = [];
            app.spouse_other_work_experience_list = []; // Consistency

            data.spouse_work.forEach((w: any) => {
                w.start_date = w.start_date ? w.start_date.substring(0, 10) : '';
                const country = (w.country || '').trim();

                if (w.work_type === 'curr_country' || w.work_type === 'other_country') {
                    if (!app.migration_spouse_data[country]) {
                        app.migration_spouse_data[country] = {
                            has_edu: false, is_currently_working: false, has_other_work: false,
                            current_work_experience_list: [], other_work_experience_list: [],
                            additional_entries: []
                        };
                    }
                    app.migration_spouse_data[country].has_work = true;
                    app.spouse_has_work_experience = true; // Ensure main toggle is ON

                    if (w.work_type === 'curr_country') {
                        app.migration_spouse_data[country].is_currently_working = true;
                        if (!app.migration_spouse_data[country].current_work_experience_list) app.migration_spouse_data[country].current_work_experience_list = [];
                        app.migration_spouse_data[country].current_work_experience_list.push(w);
                    } else {
                        app.migration_spouse_data[country].has_other_work = true;
                        if (!app.migration_spouse_data[country].other_work_experience_list) app.migration_spouse_data[country].other_work_experience_list = [];
                        app.migration_spouse_data[country].other_work_experience_list.push(w);
                    }

                    // Also add to consolidated list for registration view
                    if (!app.spouse_work_experience_list) app.spouse_work_experience_list = [];
                    if (w.country && !w.employment_country) w.employment_country = w.country;
                    app.spouse_work_experience_list.push(w);

                } else if (w.work_type === 'other' || w.work_type === 'curr_other' || w.work_type === 'prev_other') {
                    app.spouse_has_work_experience = true;
                    const isCurrent = w.type === 'current' || w.is_current === 1 || w.is_current === true;
                    
                    if (!app.spouse_work_experience_list) app.spouse_work_experience_list = [];
                    if (w.country && !w.employment_country) w.employment_country = w.country;
                    app.spouse_work_experience_list.push(w);

                    if (!isCurrent) {
                        app.spouse_has_other_work_experience = true;
                        if (!app.spouse_other_work_experience_list) app.spouse_other_work_experience_list = [];
                        app.spouse_other_work_experience_list.push(w);
                    }
                }
            });
        }

        // ── Relatives ─────────────────────────────────────────────────────────────
        if (data.relatives && data.relatives.length > 0) {
            app.relatives_list = data.relatives.map((rel: any) => ({
                country: rel.country,
                relationship: rel.relationship,
                related_to: rel.related_to || 'Applicant'
            }));
            app.has_relatives_abroad = true;
            app.has_relatives = true;
        }

        // ── Skill Assessment ──────────────────────────────────────────────────────
        if (data.application && data.application.skill_assessment_list) {
            app.skill_assessment_list = data.application.skill_assessment_list;
            app.has_skill_assessment = data.application.has_skill_assessment;
            app.skill_assessment_interest = data.application.skill_assessment_interest;
        }
    }

    goBack() {
        this.router.navigate(['/students/edit', this.studentId]);
    }

    addSkillAssessment() {
        if (!this.application.skill_assessment_list) this.application.skill_assessment_list = [];
        this.application.skill_assessment_list.push({
            country: '',
            authority: '',
            status: '',
            sub_status: ''
        });
    }

    removeSkillAssessment(index: number) {
        this.application.skill_assessment_list.splice(index, 1);
    }

    onSkillAssessmentToggle() {
        if (this.application.has_skill_assessment === true) {
            if (!this.application.skill_assessment_list || this.application.skill_assessment_list.length === 0) {
                this.addSkillAssessment();
            }
            this.application.skill_assessment_interest = null;
        } else if (this.application.has_skill_assessment === false) {
            this.application.skill_assessment_list = [];
        }
    }

    onSkillAssessmentInterestToggle() {
        if (this.application.skill_assessment_interest === true) {
            if (!this.application.skill_assessment_list || this.application.skill_assessment_list.length === 0) {
                this.addSkillAssessment();
            }
        } else {
            this.application.skill_assessment_list = [];
        }
    }
}
