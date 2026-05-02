import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, ActivatedRoute, Router } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { StudentService } from '../shared/student.service';
import { UserService } from '../shared/user.service';
import { DialogService } from '../shared/dialog.service';
import { SettingsService } from '../shared/settings.service';
import { LoadingService } from '../shared/loading.service';


@Component({
    selector: 'app-student-application',
    standalone: true,
    imports: [CommonModule, RouterModule, FormsModule],
    templateUrl: './student-application.component.html',
    styleUrls: ['./student-application.component.css']
})
export class StudentApplicationComponent implements OnInit {
    studentId: number = 0;
    student: any = {};
    studentPrograms: any = {};
    application: any = {
        passport_name: '',
        contact1: '',
        contact2: '',
        email: '',
        gender: '',
        marital_status: 'Single',
        spouse_accompanying: false,
        spouse_age: null,
        spouse_edu_level: '',
        spouse_edu_country: '',
        spouse_edu_field: '',
        spouse_has_work_experience: false,
        spouse_has_other_work_experience: false,
        spouse_other_work_experience_list: [],
        spouse_work_exp: '',
        spouse_education: [],
        has_canadian_edu: false,
        has_australian_edu: false,
        has_aus_specialised_edu: false,
        has_nz_edu: false,
        has_work_experience: false,
        work_experience_list: [],
        has_other_work_experience: false,
        other_work_experience_list: [],
        has_language_test: false,
        language_test_list: [],
        has_admission_test: false,
        admission_test_list: [],
        has_relatives: false,
        spouse_canadian_edu: false,
        spouse_australian_edu: false,
        spouse_aus_specialised_edu: false,
        migration_data: {},
        migration_spouse_data: {},
        relatives_data: {},
        spouse_work_experience_list: [],
        highest_education_status: 'Completed',
        highest_education_expected: '',
        spouse_edu_status: 'Completed',
        spouse_edu_expected: '',
        has_other_country_edu: false,
        other_country_edu_list: [],
        spouse_has_other_country_edu: false,
        spouse_other_country_edu_list: [],
        dob: '',
        citizenship_country: '',
        passport_country: '',
        has_second_passport: false,
        second_passport_country: '',
        education_country: ''
    };
    children: any[] = [];
    suggestedPrograms: any[] = [];

    rowDepartments: { [key: number]: any[] } = {};
    rowStaff: { [key: number]: any[] } = {};

    branches: any[] = [];
    allDepartments: any[] = [];
    allStaff: any[] = [];

    allAppStatuses: any[] = [];
    appSubStatuses: { [key: number]: any[] } = {};

    lookups: any = {
        countries: [],
        levels: [],
        fields: [],
        categories: []
    };

    constructor(
        private route: ActivatedRoute,
        private router: Router,
        private studentService: StudentService,
        private userService: UserService,
        private dialogService: DialogService,
        private settingsService: SettingsService,
        private loadingService: LoadingService
    ) { }

    ngOnInit() {
        this.route.params.subscribe(params => {
            this.studentId = +params['id'];
            if (this.studentId) {
                this.loadInitialData();
                this.loadApplication();
                this.loadApplicationStatuses();
            }
        });
    }

    loadApplicationStatuses() {
        this.loadingService.show();
        this.settingsService.getApplicationStatuses().subscribe({
            next: (data) => {
                this.allAppStatuses = data;
                this.resolveStatusIds();
                this.loadingService.hide();
            },
            error: () => this.loadingService.hide()
        });

        this.loadingService.show();
        this.settingsService.getApplicationSubStatuses().subscribe({
            next: (data) => {
                const grouped: any = {};
                data.forEach(ss => {
                    if (!grouped[ss.status_id]) grouped[ss.status_id] = [];
                    grouped[ss.status_id].push(ss);
                });
                this.appSubStatuses = grouped;
                this.loadingService.hide();
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
                this.lookups = data;
                this.loadingService.hide();
            },
            error: () => this.loadingService.hide()
        });

        this.loadingService.show();
        this.studentService.getBranches().subscribe({
            next: (data) => {
                this.branches = data;
                this.loadingService.hide();
            },
            error: () => this.loadingService.hide()
        });

        this.loadingService.show();
        this.studentService.getStudentById(this.studentId).subscribe({
            next: (res) => {
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
                this.loadingService.hide();
            },
            error: () => this.loadingService.hide()
        });
    }

    prePopulateFields() {
        if (!this.student || !this.application) return;
        if (!this.application.passport_name) this.application.passport_name = this.student.student_name;
        if (!this.application.contact1) this.application.contact1 = this.student.mobile_number;
        if (!this.application.mobile_country_code) this.application.mobile_country_code = this.student.mobile_country_code;
        if (!this.application.contact2) this.application.contact2 = this.student.phone_number;
        if (!this.application.phone_country_code) this.application.phone_country_code = this.student.phone_country_code;
        if (!this.application.email) this.application.email = this.student.email;
    }

    onNumberInput(event: any, field: string) {
        const val = event.target.value.replace(/[^0-9]/g, '');
        this.application[field] = val.slice(0, 10);
        event.target.value = this.application[field];
    }

    loadApplication() {
        this.loadingService.show();
        this.studentService.getStudentApplication(this.studentId).subscribe({
            next: (res) => {
                const formatMonth = (d: string) => d ? d.substring(0, 7) : '';
                if (res.application) {
                    this.application = res.application;
                    // Ensure boolean types
                    ['spouse_accompanying', 'has_canadian_edu', 'has_australian_edu', 'has_aus_specialised_edu',
                        'has_nz_edu', 'has_work_experience', 'has_language_test', 'has_admission_test', 'has_relatives',
                        'spouse_canadian_edu', 'spouse_australian_edu', 'spouse_aus_specialised_edu'].forEach(key => {
                            this.application[key] = !!this.application[key];
                        });

                    // Sync DB fields -> UI dropdowns
                    if (this.application.contact1_code) this.application.mobile_country_code = this.application.contact1_code;
                    if (this.application.contact2_code) this.application.phone_country_code = this.application.contact2_code;

                    this.prePopulateFields();

                    // Relational re-assembly moved to the end of this method to ensure suggestedPrograms are fully loaded

                    this.application.relatives_data = {};
                    if (res.relatives) {
                        res.relatives.forEach((rel: any) => {
                            const country = rel.country || 'Other';
                            this.application.relatives_data[country] = { 
                                has_rel: true, 
                                relationship: rel.relationship, 
                                related_to: rel.related_to 
                            };
                        });
                    }

                    this.application.language_test_list = [];
                    this.application.spouse_language_test_list = [];
                    if (res.language_tests) {
                        res.language_tests.forEach((t: any) => {
                            const mappedTest = {
                                type: t.test_type || t.type || '',
                                reading: t.reading_score || t.reading || '',
                                writing: t.writing_score || t.writing || '',
                                speaking: t.speaking_score || t.speaking || '',
                                listening: t.listening_score || t.listening || '',
                                overall: t.overall_score || t.overall || '',
                                is_spouse: t.is_spouse
                            };
                            if (t.is_spouse) this.application.spouse_language_test_list.push(mappedTest);
                            else this.application.language_test_list.push(mappedTest);
                        });
                    }

                    this.application.admission_test_list = [];
                    if (res.admission_tests) {
                        res.admission_tests.forEach((t: any) => {
                            this.application.admission_test_list.push({
                                type: t.test_type || t.type || '',
                                quant: t.quant_score || t.quant || '',
                                verbal: t.verbal_score || t.verbal || '',
                                data_insights: t.data_insights_score || t.data_insights || '',
                                overall: t.overall_score || t.overall || ''
                            });
                        });
                    }

                    if (this.application.language_test_list.length > 0) this.application.has_language_test = true;
                    if (this.application.spouse_language_test_list.length > 0) this.application.spouse_has_language_test = true;
                    if (this.application.admission_test_list.length > 0) this.application.has_admission_test = true;
                    this.application.spouse_work_experience_list = res.spouse_work || [];
                    this.children = res.children || [];
                    this.suggestedPrograms = res.suggestedPrograms || [];

                    // --- Legacy JSON Fallback (Only if Relational Arrays are Empty) ---
                    if (!res.education_list?.length && !res.work_experience_list?.length) {
                        if (typeof this.application.migration_data === 'string') {
                            try { this.application.migration_data = JSON.parse(this.application.migration_data); } catch (e) { this.application.migration_data = {}; }
                        }
                        if (typeof this.application.relatives_data === 'string') {
                            try { this.application.relatives_data = JSON.parse(this.application.relatives_data); } catch (e) { this.application.relatives_data = {}; }
                        }
                        if (typeof this.application.education_data === 'string') {
                            try { this.application.education_data = JSON.parse(this.application.education_data); } catch (e) { this.application.education_data = {}; }
                        }
                    }

                    // Backward compatibility for Language Tests
                    if (this.application.has_language_test && (!this.application.language_test_list || this.application.language_test_list.length === 0)) {
                        this.application.language_test_list = [{
                            type: this.application.language_test_type || '',
                            reading: this.application.reading_score || '',
                            listening: this.application.listening_score || '',
                            speaking: this.application.speaking_score || '',
                            writing: this.application.writing_score || ''
                        }];
                    }

                    // Backward compatibility for Spouse Language Tests
                    if (this.application.spouse_has_language_test && (!this.application.spouse_language_test_list || this.application.spouse_language_test_list.length === 0)) {
                        this.application.spouse_language_test_list = [{
                            type: this.application.spouse_lang_test_type || '',
                            reading: this.application.spouse_reading || '',
                            listening: this.application.spouse_listening || '',
                            speaking: this.application.spouse_speaking || '',
                            writing: this.application.spouse_writing || ''
                        }];
                    }

                    // Backward compatibility for Admission Tests
                    if (this.application.has_admission_test && (!this.application.admission_test_list || this.application.admission_test_list.length === 0)) {
                        this.application.admission_test_list = [{
                            type: this.application.admission_test_type || '',
                            quant: this.application.quant_score || '',
                            verbal: this.application.verbal_score || '',
                            data_insights: this.application.data_insights_score || ''
                        }];
                    }

                    this.initializeMigrationData();

                    // Backward compatibility sync: Map flat fields to JSON for UI
                    const countriesToSync = [
                        { name: 'Canada', prefix: 'canadian' },
                        { name: 'Australia', prefix: 'australian' },
                        { name: 'New Zealand', prefix: 'nz', altPrefix: 'nz' }
                    ];

                    // Sync unmapped education properties (Only if not already set by relational re-assembly)
                    this.application.education_country = this.application.education_country || '';
                    this.application.highest_education_status = this.application.highest_education_status || 'Completed';
                    
                    this.application.spouse_edu_status = this.application.spouse_edu_status || 'Completed';
                    this.application.spouse_edu_expected = formatMonth(this.application.spouse_edu_expected);
                    this.application.spouse_edu_country = this.application.spouse_edu_country || '';
                    this.application.spouse_edu_field = this.application.spouse_edu_field || '';
                    this.application.spouse_has_other_country_edu = this.application.spouse_has_other_country_edu || false;
                    
                    // Sync unmapped test properties from JSON
                    this.application.language_test_list = this.application.education_data.language_test_list || this.application.language_test_list || [];
                    this.application.spouse_has_language_test = this.application.education_data.spouse_has_language_test || this.application.spouse_has_language_test || false;
                    this.application.spouse_language_test_list = this.application.education_data.spouse_language_test_list || this.application.spouse_language_test_list || [];
                    this.application.admission_test_list = this.application.education_data.admission_test_list || this.application.admission_test_list || [];
                    
                    // Legacy sync removed to prevent data overwriting
                }
                this.children = (res.children || []).map((c: any) => ({ ...c, is_accompanying: !!c.is_accompanying }));
                this.suggestedPrograms = (res.suggestedPrograms || []).flatMap((p: any) => {
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

                    const result = { ...p, type, subType, country, level, field, intake, year, occupation, category, course, batch };

                    // Initialize cascading data for existing programs
                    const idx = this.suggestedPrograms.length + 0; // index in the final array depends on how flatMap works, better to do after map
                    return [result];
                });

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
                this.application.education_data = { additional: [] };
                this.application.migration_data = {};
                this.application.relatives_data = {};
                
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

                this.application.other_country_edu_list = [];
                this.application.spouse_other_country_edu_list = [];
                this.application.has_other_country_edu = false;
                
                if (res.education_list) {
                    res.education_list.forEach((edu: any) => {
                        if (edu.is_highest || edu.edu_type === 'highest') {
                            if (edu.is_highest) {
                                this.application.highest_education = edu.level;
                                this.application.education_field = edu.field;
                                this.application.education_country = edu.country;
                                this.application.highest_education_status = edu.status;
                                this.application.highest_education_expected = formatMonth(edu.expected_completion);
                            } else {
                                this.application.education_data.additional.push({
                                    ...edu,
                                    expected_completion: formatMonth(edu.expected_completion)
                                });
                            }
                        } else if (edu.edu_type === 'country') {
                            const country = edu.country;
                            const existing = this.application.education_data[country];
                            if (!existing || (!existing.level && !existing.has_edu)) {
                                // No entry yet, or pre-initialized placeholder (has_edu:false, no level) — set as primary
                                this.application.education_data[country] = { 
                                    has_edu: true, 
                                    level: edu.level, 
                                    field: edu.field, 
                                    status: edu.status, 
                                    expected_completion: formatMonth(edu.expected_completion),
                                    additional_entries: existing?.additional_entries || []
                                };
                            } else {
                                if (!existing.additional_entries) existing.additional_entries = [];
                                existing.additional_entries.push({
                                    ...edu,
                                    expected_completion: formatMonth(edu.expected_completion)
                                });
                            }
                        } else if (edu.edu_type === 'other') {
                            this.application.has_other_country_edu = true;
                            this.application.other_country_edu_list.push({
                                ...edu,
                                expected_completion: formatMonth(edu.expected_completion)
                            });
                        }
                    });
                }

                if (res.spouse_education) {
                    this.application.spouse_education = [];
                    this.application.spouse_other_country_edu_list = [];
                    // Reset main row fields to ensure they are populated from the list correctly
                    this.application.spouse_edu_country = '';
                    this.application.spouse_edu_level = '';
                    this.application.spouse_edu_field = '';
                    this.application.spouse_edu_status = 'Completed';
                    this.application.spouse_edu_expected = '';
                    this.application.spouse_has_other_country_edu = false;
                    
                    res.spouse_education.forEach((edu: any) => {
                        const formattedEdu = {
                            ...edu,
                            expected_completion: formatMonth(edu.expected_completion)
                        };
                        
                        if (edu.edu_type === 'country') {
                            const country = edu.country;
                            if (!this.application.migration_spouse_data[country]) {
                                this.application.migration_spouse_data[country] = { 
                                    has_edu: false, is_currently_working: false, has_other_work: false,
                                    current_work_experience_list: [], other_work_experience_list: [],
                                    additional_entries: []
                                };
                            }
                            
                            const data = this.application.migration_spouse_data[country];
                            if (!data.edu_level) {
                                data.has_edu = true;
                                data.edu_level = edu.level;
                                data.edu_field = edu.field;
                                data.status = edu.status || 'Completed';
                                data.expected_completion = formatMonth(edu.expected_completion);
                            } else {
                                data.additional_entries.push(formattedEdu);
                            }
                        } else if (edu.edu_type === 'highest') {
                            // Map the first 'highest' entry to the main flat fields
                            if (!this.application.spouse_edu_country) {
                                this.application.spouse_edu_country = edu.country;
                                this.application.spouse_edu_level = edu.level;
                                this.application.spouse_edu_field = edu.field;
                                this.application.spouse_edu_status = edu.status || 'Completed';
                                this.application.spouse_edu_expected = formatMonth(edu.expected_completion);
                            } else {
                                // Subsequent 'highest' entries go into the additional list
                                this.application.spouse_education.push(formattedEdu);
                            }
                        } else if (edu.edu_type === 'other') {
                            this.application.spouse_has_other_country_edu = true;
                            this.application.spouse_other_country_edu_list.push(formattedEdu);
                        }
                    });
                }

                this.application.migration_data = {};
                this.application.work_experience_list = [];
                this.application.other_work_experience_list = [];
                
                if (res.work_experience_list) {
                    res.work_experience_list.forEach((w: any) => {
                        // Sync field names for UI
                        w.employment_country = w.country;
                        const country = (w.country || '').trim();
                        
                        if (w.work_type === 'curr_country') {
                            if (this.interestedCountries.includes(country) || this.migrationCountries.includes(country)) {
                                if (!this.application.migration_data[country]) {
                                    this.application.migration_data[country] = { 
                                        has_work: true, is_currently_working: true, has_other_work: false,
                                        current_work_experience_list: [], other_work_experience_list: [] 
                                    };
                                }
                                this.application.migration_data[country].has_work = true;
                                this.application.migration_data[country].is_currently_working = true;
                                this.application.migration_data[country].current_work_experience_list.push(w);
                            }
                        } else if (w.work_type === 'other_country') {
                            if (this.interestedCountries.includes(country) || this.migrationCountries.includes(country)) {
                                if (!this.application.migration_data[country]) {
                                    this.application.migration_data[country] = { 
                                        has_work: true, is_currently_working: false, has_other_work: true,
                                        current_work_experience_list: [], other_work_experience_list: [] 
                                    };
                                }
                                this.application.migration_data[country].has_work = true;
                                this.application.migration_data[country].has_other_work = true;
                                this.application.migration_data[country].other_work_experience_list.push(w);
                            }
                        } else if (w.work_type === 'curr_other') {
                            if (w.is_current) {
                                this.application.has_work_experience = true;
                                this.application.work_experience_list.push(w);
                            } else {
                                this.application.has_other_work_experience = true;
                                this.application.other_work_experience_list.push(w);
                            }
                        }
                    });
                }

                if (res.spouse_work) {
                    this.application.spouse_work_experience_list = [];
                    this.application.spouse_other_work_experience_list = [];
                    
                    res.spouse_work.forEach((w: any) => {
                        w.employment_country = w.country;
                        const country = (w.country || '').trim();
                        
                        if (w.work_type === 'curr_country') {
                            if (!this.application.migration_spouse_data[country]) {
                                this.application.migration_spouse_data[country] = { 
                                    has_edu: false, is_currently_working: true, has_other_work: false,
                                    current_work_experience_list: [], other_work_experience_list: [],
                                    additional_entries: []
                                };
                            }
                            this.application.migration_spouse_data[country].has_work = true;
                            this.application.migration_spouse_data[country].is_currently_working = true;
                            this.application.migration_spouse_data[country].current_work_experience_list.push(w);
                        } else if (w.work_type === 'other_country') {
                            if (!this.application.migration_spouse_data[country]) {
                                this.application.migration_spouse_data[country] = { 
                                    has_edu: false, is_currently_working: false, has_other_work: true,
                                    current_work_experience_list: [], other_work_experience_list: [],
                                    additional_entries: []
                                };
                            }
                            this.application.migration_spouse_data[country].has_work = true;
                            this.application.migration_spouse_data[country].has_other_work = true;
                            this.application.migration_spouse_data[country].other_work_experience_list.push(w);
                        } else if (w.work_type === 'other') {
                            this.application.spouse_has_work_experience = true;
                            this.application.spouse_work_experience_list.push(w);
                        }
                    });
                }

                if (res.relatives) {
                    res.relatives.forEach((rel: any) => {
                        const country = (rel.country || 'Other').trim();
                        if (!this.application.relatives_data[country]) {
                            this.application.relatives_data[country] = { has_rel: false };
                        }
                        this.application.relatives_data[country].has_rel = true;
                        this.application.relatives_data[country].relationship = rel.relationship;
                        this.application.relatives_data[country].related_to = rel.related_to;
                        this.application.has_relatives = true;
                    });
                }
                this.loadingService.hide();
            },
            error: () => this.loadingService.hide()
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

    get isAgeMandatory(): boolean {
        const suggestedTypes = (this.suggestedPrograms || []).map(p => (p.type || '').toUpperCase());
        const interestTypes = (this.allInterests || []).map(p => (p.type || '').toUpperCase());
        const allTypes = [...suggestedTypes, ...interestTypes];

        if (allTypes.length === 0) {
            return false; // No programs — no asterisk
        }

        const onlyVisa = allTypes.every(t => t === 'VISA');
        return !onlyVisa;
    }

    get isGenderMandatory(): boolean {
        const suggestedTypes = (this.suggestedPrograms || []).map(p => (p.type || '').toUpperCase());
        const interestTypes = (this.allInterests || []).map(p => (p.type || '').toUpperCase());
        const allTypes = [...suggestedTypes, ...interestTypes];
        
        return allTypes.includes('WORK');
    }

    get isAddressCountryMandatory(): boolean {
        const suggestedTypes = (this.suggestedPrograms || []).map(p => (p.type || '').toUpperCase());
        const interestTypes = (this.allInterests || []).map(p => (p.type || '').toUpperCase());
        return [...suggestedTypes, ...interestTypes].length > 0;
    }

    get isAddressStateMandatory(): boolean {
        const suggestedTypes = (this.suggestedPrograms || []).map(p => (p.type || '').toUpperCase());
        const interestTypes = (this.allInterests || []).map(p => (p.type || '').toUpperCase());
        const allTypes = [...suggestedTypes, ...interestTypes];
        return allTypes.includes('WORK') || allTypes.includes('MIGRATION');
    }

    get isAddressSuburbMandatory(): boolean {
        const suggestedTypes = (this.suggestedPrograms || []).map(p => (p.type || '').toUpperCase());
        const interestTypes = (this.allInterests || []).map(p => (p.type || '').toUpperCase());
        const allTypes = [...suggestedTypes, ...interestTypes];
        return allTypes.includes('MIGRATION');
    }

    get showAgeField(): boolean {
        if (!this.suggestedPrograms || this.suggestedPrograms.length === 0) {
            return true;
        }
        const types = this.suggestedPrograms.map(p => p.type.toUpperCase());
        const onlyVisa = types.every(t => t === 'VISA');
        return !onlyVisa;
    }

    get showGeneralWorkExperience(): boolean {
        if (!this.suggestedPrograms || this.suggestedPrograms.length === 0) {
            return true;
        }
        return !this.suggestedPrograms.some(p => p.type.toUpperCase() === 'MIGRATION');
    }

    get interestedCountries(): string[] {
        const countries: string[] = [];
        
        // From Suggested Programs
        if (this.suggestedPrograms && this.suggestedPrograms.length > 0) {
            this.suggestedPrograms.forEach(p => {
                if (p.country) countries.push(p.country);
            });
        }
        
        // From Student Interests
        if (this.studentPrograms) {
            ['study', 'migration', 'visa', 'work'].forEach(type => {
                if (this.studentPrograms[type]) {
                    this.studentPrograms[type].forEach((p: any) => {
                        if (p.country) countries.push(p.country);
                    });
                }
            });
        }
        
        const unique = [...new Set(countries)];
        const order = ['Canada', 'Australia', 'New Zealand'];
        return unique.sort((a, b) => {
            const idxA = order.indexOf(a);
            const idxB = order.indexOf(b);
            if (idxA !== -1 && idxB !== -1) return idxA - idxB;
            if (idxA !== -1) return -1;
            if (idxB !== -1) return 1;
            return a.localeCompare(b);
        });
    }

    get migrationCountries(): string[] {
        const countries: string[] = [];
        
        // From Suggested Programs (Only MIGRATION)
        if (this.suggestedPrograms && this.suggestedPrograms.length > 0) {
            this.suggestedPrograms.forEach(p => {
                if (p.type === 'MIGRATION' && p.country) countries.push(p.country);
            });
        }
        
        // From Student Interests (Only MIGRATION)
        if (this.studentPrograms && this.studentPrograms.migration) {
            this.studentPrograms.migration.forEach((p: any) => {
                if (p.country) countries.push(p.country);
            });
        }
        
        const unique = [...new Set(countries)];
        const order = ['Canada', 'Australia', 'New Zealand'];
        return unique.sort((a, b) => {
            const idxA = order.indexOf(a);
            const idxB = order.indexOf(b);
            if (idxA !== -1 && idxB !== -1) return idxA - idxB;
            if (idxA !== -1) return -1;
            if (idxB !== -1) return 1;
            return a.localeCompare(b);
        });
    }

    initializeMigrationData() {
        if (!this.application.migration_data) this.application.migration_data = {};
        if (!this.application.migration_spouse_data) this.application.migration_spouse_data = {};
        if (!this.application.relatives_data) this.application.relatives_data = {};
        if (!this.application.education_data) this.application.education_data = {};

        if (!this.application.work_experience_list) this.application.work_experience_list = [];
        if (!this.application.spouse_work_experience_list) this.application.spouse_work_experience_list = [];
        if (!this.application.other_work_experience_list) this.application.other_work_experience_list = [];
        if (!this.application.spouse_other_work_experience_list) this.application.spouse_other_work_experience_list = [];

        if (!this.application.migration_spouse_data['General']) {
            this.application.migration_spouse_data['General'] = { has_edu: false, edu_level: '', edu_field: '', has_work: false, work_years: '' };
        }

        this.interestedCountries.forEach(country => {
            if (!this.application.migration_data[country]) {
                this.application.migration_data[country] = { 
                    has_edu: false, edu_level: '', edu_field: '', 
                    has_work: false, 
                    is_currently_working: false, 
                    current_work_experience_list: [],
                    has_other_work: false,
                    other_work_experience_list: [],
                    work_years: '' 
                };
            }
            if (!this.application.migration_spouse_data[country]) {
                this.application.migration_spouse_data[country] = { 
                    has_edu: false, edu_level: '', edu_field: '', 
                    has_work: false, 
                    is_currently_working: false, 
                    current_work_experience_list: [],
                    has_other_work: false,
                    other_work_experience_list: [],
                    work_years: '',
                    status: 'Completed',
                    additional_entries: []
                };
            }
            if (!this.application.relatives_data[country]) {
                this.application.relatives_data[country] = { has_rel: false, relationship: '', related_to: 'Applicant' };
            }
        });

        this.migrationCountries.forEach(country => {
            if (!this.application.education_data[country]) {
                this.application.education_data[country] = { has_edu: false, level: '', field: '', status: 'Completed', expected_completion: '', additional_entries: [] };
            } else {
                if (!this.application.education_data[country].additional_entries) {
                    this.application.education_data[country].additional_entries = [];
                }
                if (!this.application.education_data[country].status) {
                    this.application.education_data[country].status = 'Completed';
                }
            }
        });

        if (!this.application.spouse_education) {
            this.application.spouse_education = [];
        }

        if (!this.application.education_data.additional) {
            this.application.education_data.additional = [];
        }

        if (!this.application.other_country_edu_list) {
            this.application.other_country_edu_list = [];
        }
        if (!this.application.spouse_other_country_edu_list) {
            this.application.spouse_other_country_edu_list = [];
        }

        if (this.application.spouse_has_work_experience === undefined) this.application.spouse_has_work_experience = false;
        if (this.application.spouse_work_experience_years === undefined) this.application.spouse_work_experience_years = '';
        if (this.application.spouse_has_language_test === undefined) this.application.spouse_has_language_test = false;
        if (!this.application.spouse_language_test_list) this.application.spouse_language_test_list = [];
    }

    addQualification() {
        if (!this.application.education_data.additional) {
            this.application.education_data.additional = [];
        }
        this.application.education_data.additional.push({ country: '', level: '', field: '', status: 'Completed', expected_completion: '' });
    }

    addCountryEducation(country: string) {
        if (!this.application.education_data[country].additional_entries) {
            this.application.education_data[country].additional_entries = [];
        }
        this.application.education_data[country].additional_entries.push({ 
            level: '', 
            field: '', 
            status: 'Completed', 
            expected_completion: '' 
        });
    }

    removeCountryEducation(country: string, index: number) {
        this.application.education_data[country].additional_entries.splice(index, 1);
    }

    addSpouseCountryEducation(country: string) {
        if (!this.application.migration_spouse_data[country].additional_entries) {
            this.application.migration_spouse_data[country].additional_entries = [];
        }
        this.application.migration_spouse_data[country].additional_entries.push({ 
            level: '', 
            field: '', 
            status: 'Completed', 
            expected_completion: '' 
        });
    }

    removeSpouseCountryEducation(country: string, index: number) {
        this.application.migration_spouse_data[country].additional_entries.splice(index, 1);
    }

    addSpouseQualification() {
        if (!this.application.spouse_education) {
            this.application.spouse_education = [];
        }
        this.application.spouse_education.push({ 
            country: '',
            level: '', 
            field: '', 
            status: 'Completed', 
            expected_completion: '' 
        });
    }

    removeSpouseQualification(index: number) {
        if (this.application.spouse_education && this.application.spouse_education[index]) {
            this.application.spouse_education.splice(index, 1);
        }
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

    addOtherCountryEducation(target: 'applicant' | 'spouse' = 'applicant') {
        const list = target === 'applicant' ? this.application.other_country_edu_list : this.application.spouse_other_country_edu_list;
        list.push({ country: '', level: '', field: '', status: 'Completed', expected_completion: '' });
    }

    removeOtherCountryEducation(index: number, target: 'applicant' | 'spouse' = 'applicant') {
        const list = target === 'applicant' ? this.application.other_country_edu_list : this.application.spouse_other_country_edu_list;
        list.splice(index, 1);
    }

    hasInterest(type: 'study' | 'migration' | 'visa' | 'work' | 'coaching'): boolean {
        return !!(this.studentPrograms && this.studentPrograms[type] && this.studentPrograms[type].length > 0);
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

        // Map UI-only education properties into education_data JSON for saving
        if (!this.application.education_data) this.application.education_data = {};
        this.application.education_data.highest_education_status = this.application.highest_education_status;
        this.application.education_data.highest_education_expected = this.application.highest_education_expected;
        this.application.education_data.education_country = this.application.education_country;
        this.application.education_data.has_other_country_edu = this.application.has_other_country_edu;
        this.application.education_data.other_country_edu_list = this.application.has_other_country_edu ? this.application.other_country_edu_list : [];
        this.application.education_data.spouse_edu_status = this.application.spouse_edu_status;
        this.application.education_data.spouse_edu_expected = this.application.spouse_edu_expected;
        this.application.education_data.spouse_edu_country = this.application.spouse_edu_country;
        this.application.education_data.spouse_edu_field = this.application.spouse_edu_field;
        this.application.education_data.spouse_education = this.application.spouse_education;
        this.application.education_data.spouse_has_other_country_edu = this.application.spouse_has_other_country_edu;
        this.application.education_data.spouse_other_country_edu_list = this.application.spouse_has_other_country_edu ? this.application.spouse_other_country_edu_list : [];
        this.application.education_data.language_test_list = this.application.has_language_test ? this.application.language_test_list : [];
        this.application.education_data.spouse_has_language_test = this.application.spouse_has_language_test;
        this.application.education_data.spouse_language_test_list = this.application.spouse_has_language_test ? this.application.spouse_language_test_list : [];
        this.application.education_data.admission_test_list = this.application.has_admission_test ? this.application.admission_test_list : [];

        // Map UI-only work properties into migration_data JSON for saving
        if (!this.application.migration_data) this.application.migration_data = {};
        if (!this.application.migration_data['General']) this.application.migration_data['General'] = {};
        this.application.migration_data['General'].work_experience_list = this.application.has_work_experience ? this.application.work_experience_list : [];
        this.application.migration_data['General'].has_other_work_experience = this.application.has_other_work_experience;
        this.application.migration_data['General'].other_work_experience_list = this.application.has_other_work_experience ? this.application.other_work_experience_list : [];

        if (!this.application.migration_spouse_data) this.application.migration_spouse_data = {};
        if (!this.application.migration_spouse_data['General']) this.application.migration_spouse_data['General'] = {};
        this.application.migration_spouse_data['General'].spouse_has_other_work_experience = this.application.spouse_has_other_work_experience;
        this.application.migration_spouse_data['General'].spouse_other_work_experience_list = this.application.spouse_has_other_work_experience ? this.application.spouse_other_work_experience_list : [];

        // Validate children if any
        if (this.children.length > 0) {
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

        if (this.isAgeMandatory && (!this.application.age || this.application.age <= 0)) {
            this.dialogService.error('Please provide Age.');
            return;
        }

        if (this.isGenderMandatory && !this.application.gender) {
            this.dialogService.error('Please select Gender.');
            return;
        }

        if (this.isAddressCountryMandatory && !this.application.address_country) {
            this.dialogService.error('Please select Present Address Country.');
            return;
        }

        if (this.isAddressStateMandatory && !this.application.address_state) {
            this.dialogService.error('Please enter State / Territory.');
            return;
        }

        if (this.isAddressSuburbMandatory && !this.application.address_suburb) {
            this.dialogService.error('Please enter Suburb / Town.');
            return;
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
        if (this.application.highest_education) {
            education_list.push({
                country: this.application.education_country || '',
                level: this.application.highest_education,
                field: this.application.education_field,
                status: this.application.highest_education_status || 'Completed',
                expected_completion: this.application.highest_education_expected || null,
                edu_type: 'highest',
                is_highest: 1
            });
        }

        if (this.application.education_data) {
            Object.keys(this.application.education_data).forEach(country => {
                if (country === 'additional') {
                    // Highest/Current Study additional rows
                    const additional = this.application.education_data[country];
                    if (Array.isArray(additional)) {
                        additional.forEach((q: any) => {
                            education_list.push({
                                country: q.country || '',
                                level: q.level,
                                field: q.field,
                                status: q.status || 'Completed',
                                expected_completion: q.expected_completion || null,
                                edu_type: 'highest',
                                is_highest: 0
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
                                country: country,
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

        // Add Other Country Education List
        if (this.application.has_other_country_edu && this.application.other_country_edu_list) {
            this.application.other_country_edu_list.forEach((edu: any) => {
                education_list.push({
                    country: edu.country || 'Other',
                    level: edu.level,
                    field: edu.field,
                    status: edu.status || 'Completed',
                    expected_completion: edu.expected_completion || null,
                    edu_type: 'other',
                    is_highest: 0
                });
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
                        country: w.employment_country || 'General',
                        job_title: w.job_title,
                        work_years: parseInt(w.work_years) || 0,
                        work_months: parseInt(w.work_months) || 0,
                        is_current: 1,
                        work_type: 'curr_other'
                    });
                }
            });
        }

        if (this.application.has_other_work_experience && this.application.other_work_experience_list) {
            this.application.other_work_experience_list.forEach((w: any) => {
                if (w.job_title) {
                    work_experience_list.push({
                        country: w.employment_country || 'General',
                        job_title: w.job_title,
                        work_years: parseInt(w.work_years) || 0,
                        work_months: parseInt(w.work_months) || 0,
                        is_current: 0,
                        work_type: 'curr_other'
                    });
                }
            });
        }

        if (this.application.migration_data) {
            this.migrationCountries.forEach(country => {
                const mig = this.application.migration_data[country];
                if (mig && mig.has_work) {
                    if (mig.is_currently_working && mig.current_work_experience_list) {
                        mig.current_work_experience_list.forEach((w: any) => {
                            if (w.job_title) {
                                work_experience_list.push({
                                    country: country,
                                    job_title: w.job_title,
                                    work_years: parseInt(w.work_years) || 0,
                                    work_months: parseInt(w.work_months) || 0,
                                    is_current: 1,
                                    work_type: 'curr_country'
                                });
                            }
                        });
                    }
                    if (mig.has_other_work && mig.other_work_experience_list) {
                        mig.other_work_experience_list.forEach((w: any) => {
                            if (w.job_title) {
                                work_experience_list.push({
                                    country: country,
                                    job_title: w.job_title,
                                    work_years: parseInt(w.work_years) || 0,
                                    work_months: parseInt(w.work_months) || 0,
                                    is_current: 0,
                                    work_type: 'other_country'
                                });
                            }
                        });
                    }
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
                        work_years: parseInt(w.work_years) || 0,
                        work_months: parseInt(w.work_months) || 0,
                        work_type: 'other'
                    });
                }
            });
        }
        if (this.application.spouse_has_other_work_experience && this.application.spouse_other_work_experience_list) {
            this.application.spouse_other_work_experience_list.forEach((w: any) => {
                if (w.job_title) {
                    spouse_work.push({
                        country: w.employment_country || 'General',
                        job_title: w.job_title,
                        work_years: parseInt(w.work_years) || 0,
                        work_months: parseInt(w.work_months) || 0,
                        work_type: 'other'
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
        if (this.application.relatives_data) {
            Object.keys(this.application.relatives_data).forEach(country => {
                const rel = this.application.relatives_data[country];
                if (rel && rel.has_rel) {
                    relatives.push({
                        country: country,
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
            relatives
        };

        this.loadingService.show();
        this.studentService.saveStudentApplication(this.studentId, data).subscribe({
            next: () => {
                this.dialogService.success('Application saved successfully');
                this.loadingService.hide();
            },
            error: (err) => {
                this.dialogService.error('Error saving application: ' + err.message);
                this.loadingService.hide();
            }
        });
    }

    onRegisterNow() {
        if (!this.suggestedPrograms.some(p => p.is_selected)) {
            this.dialogService.warn('Please select at least one program to register.');
            return;
        }
        this.router.navigate(['/students/registration', this.studentId]);
    }

    addWorkExperience(country: string | null, target: string, subTarget: string = 'work_experience_list') {
        const newItem = { job_title: '', work_years: '', work_months: '', employment_country: '' };
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
        if (country) {
            const countryData = this.application[target][country];
            const hasWork = subTarget === 'current_work_experience_list' ? countryData.is_currently_working :
                           subTarget === 'other_work_experience_list' ? countryData.has_other_work :
                           countryData.has_work;

            if (hasWork && (!countryData[subTarget] || countryData[subTarget].length === 0)) {
                this.addWorkExperience(country, target, subTarget);
            }
        } else {
            const hasWork = target === 'work_experience_list' ? this.application.has_work_experience :
                target === 'other_work_experience_list' ? this.application.has_other_work_experience :
                    target === 'spouse_work_experience_list' ? this.application.spouse_has_work_experience :
                        this.application.spouse_has_other_work_experience;

            if (hasWork && (!this.application[target] || this.application[target].length === 0)) {
                this.addWorkExperience(null, target);
            }
        }
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


    onDobChange() {
        if (!this.application.dob) return;
        const birthDate = new Date(this.application.dob);
        const today = new Date();
        let age = today.getFullYear() - birthDate.getFullYear();
        const m = today.getMonth() - birthDate.getMonth();
        if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
            age--;
        }
        this.application.age = age;
    }

    goBack() {
        this.router.navigate(['/students/edit', this.studentId]);
    }
}
