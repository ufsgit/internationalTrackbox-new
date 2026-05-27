import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, ActivatedRoute, Router } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { NgSelectModule } from '@ng-select/ng-select';
import { StudentService } from '../shared/student.service';
import { UserService } from '../shared/user.service';
import { DialogService } from '../shared/dialog.service';
import { SettingsService } from '../shared/settings.service';
import { LoadingService } from '../shared/loading.service';


@Component({
    selector: 'app-student-application',
    standalone: true,
    imports: [CommonModule, RouterModule, FormsModule, NgSelectModule],
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
        spouse_work_exp: '',
        spouse_education: [],
        has_canadian_edu: false,
        has_australian_edu: false,
        has_aus_specialised_edu: false,
        has_nz_edu: false,
        has_work_experience: false,
        work_experience_list: [],
        has_language_test: null,
        language_test_list: [],
        has_admission_test: null,
        admission_test_list: [],
        has_relatives: false,
        has_relatives_abroad: false,
        relatives_list: [],
        spouse_canadian_edu: false,
        spouse_australian_edu: false,
        spouse_aus_specialised_edu: false,
        migration_data: {},
        migration_spouse_data: {},
        relatives_data: {},
        highest_education_status: 'Completed',
        highest_education_expected: '',
        spouse_edu_status: 'Completed',
        spouse_edu_expected: '',
        dob: '',
        citizenship_country: '',
        passport_country: '',
        has_second_passport: false,
        second_passport_country: '',
        education_country: '',
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

    allAppStatuses: any[] = [];
    appSubStatuses: { [key: number]: any[] } = {};

    // Year options for intake year datalist - generated locally, independent of API
    yearOptions: string[] = Array.from({length: 8}, (_, i) => String(new Date().getFullYear() - 1 + i));

    relationshipOptions = ['Parent', 'Sibling', 'Uncle/Aunty', 'Cousin', 'Friend'];
    relatedToOptions = [
        { label: 'Related to Applicant', value: 'Applicant' },
        { label: 'Related to Spouse', value: 'Spouse' }
    ];

    lookups: any = {
        countries: [],
        levels: [],
        fields: [],
        categories: [],
        coachingCourses: [],
        admissionCourses: [],
        languageCourses: [],
        boardAuthorities: [],
        otherTypes: [],
        intakes: [],
        occupations: [],
        years: ((): {name: string}[] => {
            const currentYear = new Date().getFullYear();
            return Array.from({length: 8}, (_, i) => ({ name: String(currentYear - 1 + i) }));
        })()
    };
    private lastSavedSnapshot: string = '';

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
            let selected = this.allAppStatuses.find(s => s.name === p.status && (s.categories || []).includes(p.type));
            if (!selected) {
                selected = this.allAppStatuses.find(s => s.name === p.status && (s.categories || []).includes('OTHER'));
            }
            if (!selected) {
                selected = this.allAppStatuses.find(s => s.name === p.status);
            }
            p.status_id = selected ? selected.status_id : null;
        });
    }

    getFilteredStatuses(category: string) {
        if (!category) return [];
        // Match category with the list of categories in status
        const cat = category.toUpperCase();
        const filtered = this.allAppStatuses.filter(s => (s.categories || []).includes(cat));
        if (filtered.length > 0) {
            return filtered;
        }
        const fallback = this.allAppStatuses.filter(s => (s.categories || []).includes('OTHER'));
        return fallback.length > 0 ? fallback : this.allAppStatuses;
    }

    onStatusChange(p: any) {
        // Find the status_id for the selected status name to filter sub-statuses
        let selected = this.allAppStatuses.find(s => s.name === p.status && (s.categories || []).includes(p.type));
        if (!selected) {
            selected = this.allAppStatuses.find(s => s.name === p.status && (s.categories || []).includes('OTHER'));
        }
        if (!selected) {
            selected = this.allAppStatuses.find(s => s.name === p.status);
        }
        p.status_id = selected ? selected.status_id : null;
        p.sub_status = ''; // reset sub-status on main status change
    }

    loadInitialData() {
        this.loadingService.show();
        this.studentService.getLookups().subscribe({
            next: (data: any) => {
                // Preserve the generated years list if API doesn't return one
                const generatedYears = this.lookups.years;
                this.lookups = data;
                if (!this.lookups.years || this.lookups.years.length === 0) {
                    this.lookups.years = generatedYears;
                }
                if (!this.lookups.intakes) this.lookups.intakes = [];
                if (!this.lookups.occupations) this.lookups.occupations = [];
                if (!this.lookups.otherTypes) this.lookups.otherTypes = [];
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
                const hasInterests = this.suggestedPrograms.some(p => ['STUDY', 'MIGRATION', 'VISA', 'WORK', 'COACHING'].includes(p.type));
                if (!hasInterests) {
                    this.syncSuggestedPrograms();
                }
                // Re-capture snapshot after student data mutates application fields,
                // because this callback may resolve after loadApplication's captureSnapshot().
                if (this.lastSavedSnapshot) {
                    this.captureSnapshot();
                }
                this.loadingService.hide();
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

        // Auto-fill communication preferences from student profile if not already set (checks for undefined or null)
        const isSet = (val: any) => val !== undefined && val !== null;
        
        if (!isSet(this.application.contact1_whatsapp)) this.application.contact1_whatsapp = !!this.student.whatsapp;
        if (!isSet(this.application.contact1_bot))      this.application.contact1_bot      = !!this.student.botim;
        if (!isSet(this.application.contact1_telegram)) this.application.contact1_telegram = !!this.student.telegram;
        if (!isSet(this.application.contact2_whatsapp)) this.application.contact2_whatsapp = !!this.student.phone_whatsapp;
        if (!isSet(this.application.contact2_bot))      this.application.contact2_bot      = !!this.student.phone_botim;
        if (!isSet(this.application.contact2_telegram)) this.application.contact2_telegram = !!this.student.phone_telegram;
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
                    const toNullableBool = (value: any) => {
                        if (value === null || value === undefined || value === '') return null;
                        if (value === true || value === 1 || value === '1') return true;
                        if (value === false || value === 0 || value === '0') return false;
                        return null;
                    };
                    // Ensure boolean types
                    ['spouse_accompanying', 'has_canadian_edu', 'has_australian_edu', 'has_aus_specialised_edu',
                        'has_nz_edu', 'has_work_experience', 'has_language_test', 'has_admission_test', 'has_relatives',
                        'spouse_canadian_edu', 'spouse_australian_edu', 'spouse_aus_specialised_edu',
                        'contact1_whatsapp', 'contact1_bot', 'contact1_telegram',
                        'contact2_whatsapp', 'contact2_bot', 'contact2_telegram',
                        'has_language_interest', 'has_admission_interest',
                        'has_skill_assessment', 'skill_assessment_interest'].forEach(key => {
                            this.application[key] = toNullableBool(this.application[key]);
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
                            const testType = t.test_type || t.type || '';
                            if (!testType) return;
                            const mappedTest = {
                                type: testType,
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
                            const testType = t.test_type || t.type || '';
                            if (!testType) return;
                            this.application.admission_test_list.push({
                                type: testType,
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
                    this.application.skill_assessment_list = res.skill_assessment_list || [];
                    this.children = res.children || [];


                    // Language Interests
                    if (res.lang_interest && res.lang_interest.length > 0) {
                        this.application.interested_in_lang_coaching = true;
                        this.application.lang_coaching_course = res.lang_interest[0].course;
                        this.application.expected_lang_coaching_date = res.lang_interest[0].expected_date ? res.lang_interest[0].expected_date.substring(0, 10) : '';
                    }

                    // Spouse Language Interests
                    if (res.spouse_lang_interest && res.spouse_lang_interest.length > 0) {
                        this.application.spouse_interested_in_lang_coaching = true;
                        this.application.spouse_lang_coaching_course = res.spouse_lang_interest[0].course;
                        this.application.spouse_expected_lang_coaching_date = res.spouse_lang_interest[0].expected_date ? res.spouse_lang_interest[0].expected_date.substring(0, 10) : '';
                    }

                    // Admission Interests
                    if (res.adm_interest && res.adm_interest.length > 0) {
                        this.application.interested_in_admission_coaching = true;
                        this.application.admission_coaching_course = res.adm_interest[0].course;
                        this.application.expected_admission_coaching_date = res.adm_interest[0].expected_date ? res.adm_interest[0].expected_date.substring(0, 10) : '';
                    }

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
                    if (this.application.spouse_has_language_test !== undefined && this.application.spouse_has_language_test !== null) {
                        this.application.spouse_has_language_test = !!this.application.spouse_has_language_test;
                    } else if (this.application.education_data?.spouse_has_language_test !== undefined && this.application.education_data?.spouse_has_language_test !== null) {
                        this.application.spouse_has_language_test = !!this.application.education_data.spouse_has_language_test;
                    } else {
                        this.application.spouse_has_language_test = null;
                    }
                    this.application.spouse_language_test_list = this.application.education_data.spouse_language_test_list || this.application.spouse_language_test_list || [];
                    this.application.admission_test_list = this.application.education_data.admission_test_list || this.application.admission_test_list || [];
                    
                    // Legacy sync removed to prevent data overwriting
                }
                this.children = (res.children || []).map((c: any) => ({ ...c, is_accompanying: !!c.is_accompanying }));
                this.suggestedPrograms = this.parseSuggestedPrograms(res.suggestedPrograms || []);

                // After loading, initialize cascading maps
                this.suggestedPrograms.forEach((p, i) => {
                    if (p.branch_id) this.loadRowDepartments(i, p.branch_id);
                    if (p.branch_id && p.department_id) this.loadRowStaff(i, p.branch_id, p.department_id);
                });

                this.resolveStatusIds();

                const hasInterests = this.suggestedPrograms.some(p => ['STUDY', 'MIGRATION', 'VISA', 'WORK', 'COACHING'].includes(p.type));
                if (!hasInterests) {
                    this.syncSuggestedPrograms();
                }

                // --- Relational Re-assembly ---
                this.application.education_data = { additional: [] };
                this.application.migration_data = {};
                this.application.migration_spouse_data = {};
                this.application.relatives_data = {};
                this.application.relatives_list = [];
                
                // Pre-initialize for all countries to ensure UI toggles work
                this.migrationCountries.forEach(country => {
                    this.application.migration_data[country] = { 
                        has_work: false, current_work_experience_list: [], work_experience_list: [] 
                    };
                    this.application.migration_spouse_data[country] = { 
                        has_edu: false, current_work_experience_list: [], work_experience_list: [],
                        additional_entries: []
                    };
                });

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
                        } else if (edu.edu_type === 'country' || edu.edu_type === 'other') {
                            this.application.education_data.additional.push({
                                ...edu,
                                expected_completion: formatMonth(edu.expected_completion)
                            });
                        }
                    });
                }

                if (res.spouse_education) {
                    this.application.spouse_education = [];
                    // Reset main row fields to ensure they are populated from the list correctly
                    this.application.spouse_edu_country = '';
                    this.application.spouse_edu_level = '';
                    this.application.spouse_edu_field = '';
                    this.application.spouse_edu_status = 'Completed';
                    this.application.spouse_edu_expected = '';
                    
                    res.spouse_education.forEach((edu: any) => {
                        const formattedEdu = {
                            ...edu,
                            expected_completion: formatMonth(edu.expected_completion)
                        };
                        
                        this.application.spouse_education.push(formattedEdu);
                    });
                }

                this.application.work_experience_list = [];
                
                if (res.work_experience_list) {
                    res.work_experience_list.forEach((w: any) => {
                        w.employment_country = w.country;
                        w.start_date = w.start_date ? w.start_date.substring(0, 10) : '';
                        const country = (w.country || '').trim();
                        
                        if (w.work_type === 'curr_country' || w.work_type === 'other_country') {
                            if (!this.application.migration_data[country]) {
                                this.application.migration_data[country] = { work_experience_list: [] };
                            }
                            this.application.migration_data[country].work_experience_list.push(w);
                        } else {
                            this.application.has_work_experience = true;
                            this.application.work_experience_list.push(w);
                        }
                    });
                }

                if (res.spouse_work) {
                    this.application.spouse_work_experience_list = [];
                    res.spouse_work.forEach((w: any) => {
                        w.employment_country = w.country;
                        w.start_date = w.start_date ? w.start_date.substring(0, 10) : '';
                        const country = (w.country || '').trim();
                        
                        if (w.work_type === 'curr_country' || w.work_type === 'other_country') {
                            if (!this.application.migration_spouse_data[country]) {
                                this.application.migration_spouse_data[country] = { work_experience_list: [] };
                            }
                            this.application.migration_spouse_data[country].work_experience_list.push(w);
                        } else {
                            this.application.spouse_has_work_experience = true;
                            this.application.spouse_work_experience_list.push(w);
                        }
                    });
                }

                if (res.relatives) {
                    this.application.relatives_list = res.relatives.map((rel: any) => ({
                        country: rel.country,
                        relationship: rel.relationship,
                        related_to: rel.related_to || 'Applicant'
                    }));
                    if (this.application.relatives_list.length > 0) {
                        this.application.has_relatives_abroad = true;
                        this.application.has_relatives = true;
                    }
                }
                this.onTestCompletionChange();
                this.captureSnapshot();
                this.loadingService.hide();
            },
            error: () => this.loadingService.hide()
        });
    }

    private buildSnapshot(): string {
        return JSON.stringify({
            application: this.application,
            children: this.children,
            suggestedPrograms: this.suggestedPrograms
        });
    }

    private captureSnapshot() {
        this.lastSavedSnapshot = this.buildSnapshot();
    }

    private hasUnsavedChanges(): boolean {
        if (!this.lastSavedSnapshot) return false;
        return this.buildSnapshot() !== this.lastSavedSnapshot;
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

    getBadgeClass(p: any): string {
        const type = (p.type || '').toUpperCase();
        if (type === 'OTHER') {
            const prog = (p.program || '').toUpperCase();
            if (prog === 'LANGUAGE TEST') return 'language';
            if (prog === 'ADMISSION TEST') return 'admission';
            if (prog === 'SPOUSE LANGUAGE TEST') return 'spouse-language';
            if (prog === 'SKILL ASSESSMENT') return 'skill-assessment';
            return 'other';
        }
        if (type === 'LANGUAGE TEST') return 'language';
        if (type === 'ADMISSION TEST') return 'admission';
        if (type === 'SPOUSE LANGUAGE TEST') return 'spouse-language';
        if (type === 'SKILL ASSESSMENT') return 'skill-assessment';
        return type.toLowerCase().replace(/_/g, '-');
    }

    getBadgeText(p: any): string {
        const type = (p.type || '').toUpperCase();
        if (type === 'OTHER') {
            const prog = (p.program || '').toUpperCase();
            if (prog === 'LANGUAGE TEST') return 'LANGUAGE';
            if (prog === 'ADMISSION TEST') return 'ADMISSION';
            if (prog === 'SPOUSE LANGUAGE TEST') return 'SPOUSE LANGUAGE';
            if (prog === 'SKILL ASSESSMENT') return 'SKILL ASSESSMENT';
            return 'OTHER';
        }
        if (type === 'SPOUSE LANGUAGE TEST') return 'SPOUSE LANGUAGE';
        return type;
    }

    getProgramColumnType(p: any): string {
        const type = p.type || '';
        if (['Admission Test', 'Language Test', 'Spouse Language Test', 'Skill Assessment', 'OTHER'].includes(type)) {
            return 'OTHER';
        }
        return type;
    }

    isWideRow(p: any): boolean {
        const type = this.getProgramColumnType(p);
        return ['OTHER', 'COACHING', 'MIGRATION'].includes(type);
    }

    isFullWideRow(p: any): boolean {
        const type = p.type || '';
        return ['EDUCATION LOAN', 'TICKETING', 'FOREX'].includes(type);
    }

    removeChild(index: number) {
        this.children.splice(index, 1);
    }

    parseSuggestedPrograms(programs: any[]): any[] {
        return (programs || []).map((p: any) => {
            const upperProg = (p.program || '').toUpperCase();
            let type = p.program_type || 'OTHER';

            if (!p.program_type || p.program_type === 'OTHER') {
                if (upperProg.includes('STUDY')) type = 'STUDY';
                else if (upperProg.includes('MIGRATION')) type = 'MIGRATION';
                else if (upperProg.includes('VISA')) type = 'VISA';
                else if (upperProg.includes('WORK')) type = 'WORK';
                else if (upperProg.includes('COACHING')) type = 'COACHING';
                else if (upperProg === 'LANGUAGE TEST') type = 'Language Test';
                else if (upperProg === 'ADMISSION TEST') type = 'Admission Test';
                else if (upperProg === 'SPOUSE LANGUAGE TEST') type = 'Spouse Language Test';
                else if (upperProg === 'SKILL ASSESSMENT') type = 'Skill Assessment';
            }

            // Extract country from program name (e.g., "STUDY Canada" -> "Canada")
            let country = '';
            if (type === 'STUDY') country = (p.program || '').replace(/STUDY/i, '').trim();
            else if (type === 'MIGRATION') country = (p.program || '').replace(/MIGRATION/i, '').trim();
            else if (type === 'VISA') country = (p.program || '').replace(/VISA/i, '').trim();
            else if (type === 'WORK') country = (p.program || '').replace(/WORK/i, '').trim();

            // Set up structured columns, falling back to old parsing if applied_for is empty/null
            let applied_for = p.applied_for || '';
            let details = p.details || '';
            let details2 = p.details2 || '';
            let details3 = p.details3 || '';

            if (!applied_for && p.details) {
                // Fallback parsing for legacy records
                if (type === 'STUDY') {
                    const mainParts = p.details.split(' - ');
                    const courseParts = (mainParts[0] || '').split(' ');
                    const intakeParts = (mainParts[1] || '').split(' ');

                    applied_for = courseParts[0] || '';
                    details = courseParts.slice(1).join(' ') || '';
                    details2 = intakeParts[0] || '';
                    details3 = intakeParts[1] || '';
                } else if (type === 'MIGRATION') {
                    const parts = p.details.split(' - ');
                    applied_for = parts[0] || '';
                    details = parts[1] || '';
                } else if (type === 'VISA') {
                    const parts = p.details.split(' - ');
                    applied_for = parts[0] || '';
                    details = parts.slice(1).join(' - ') || '';
                } else if (type === 'WORK') {
                    const parts = p.details.split(' - ');
                    applied_for = parts[0] || '';
                    details = parts.slice(1).join(' - ') || '';
                } else if (type === 'COACHING') {
                    const parts = p.details.split(' - ');
                    applied_for = parts[0] || '';
                    details = parts[1] || '';
                }
            }

            return {
                ...p,
                type,
                subType: 'default',
                country,
                applied_for,
                details,
                details2,
                details3,
                _isSystem: !!p.issystem,
                is_selected: (p.is_selected === true || p.is_selected === 1) ? 1 : 
                             (p.is_selected === 2) ? 2 : 
                             (p.is_selected === 0 || p.is_selected === false) ? 0 : null
            };
        });
    }

    addSuggestedProgram(type: string, programName: string = '', isSystem: boolean = false) {
        if (type === 'STUDY') {
            const common = {
                type,
                program: type,
                details: '',
                status: '',
                sub_status: '',
                remarks: '',
                is_selected: 0,
                branch_id: null,
                department_id: null,
                assigned_to: null,
                country: '',
                applied_for: '',
                details2: '',
                details3: ''
            };
            this.suggestedPrograms.push({ ...common, subType: 'default', _isSystem: isSystem });
        } else {
            const newProg: any = {
                type,
                subType: 'default',
                program: programName || (type === 'OTHER' ? '' : type),
                details: '',
                status: '',
                sub_status: '',
                remarks: '',
                is_selected: 0,
                branch_id: null,
                department_id: null,
                assigned_to: null,
                country: '',
                applied_for: '',
                details2: '',
                details3: '',
                _isSystem: isSystem
            };
            this.suggestedPrograms.push(newProg);
        }
        this.initializeMigrationData();
    }

    onCountryChange(p: any) {
        if (p.type === 'STUDY') {
            p.program = `${p.country || ''}`.trim();
        } else if (p.type === 'MIGRATION') {
            p.program = `${p.country || ''}`.trim();
        } else if (p.type === 'VISA') {
            p.program = `${p.country || ''}`.trim();
        } else if (p.type === 'WORK') {
            p.program = `${p.country || ''}`.trim();
        } else if (p.type === 'COACHING') {
            p.program = `COACHING`;
        }
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

    private _lastInterestedCountries: string[] = [];
    get interestedCountries(): string[] {
        const countries: string[] = [];
        
        // From Suggested Programs (Only STUDY and MIGRATION)
        if (this.suggestedPrograms && this.suggestedPrograms.length > 0) {
            this.suggestedPrograms.forEach(p => {
                if (p.country && (p.type === 'STUDY' || p.type === 'MIGRATION')) {
                    countries.push(p.country);
                }
            });
        }
        
        // From Student Interests (Only STUDY and MIGRATION)
        if (this.studentPrograms) {
            ['study', 'migration'].forEach(type => {
                if (this.studentPrograms[type]) {
                    this.studentPrograms[type].forEach((p: any) => {
                        if (p.country) countries.push(p.country);
                    });
                }
            });
        }
        
        const unique = [...new Set(countries)];
        const order = ['Canada', 'Australia', 'New Zealand'];
        const current = unique.sort((a, b) => {
            const idxA = order.indexOf(a);
            const idxB = order.indexOf(b);
            if (idxA !== -1 && idxB !== -1) return idxA - idxB;
            if (idxA !== -1) return -1;
            if (idxB !== -1) return 1;
            return a.localeCompare(b);
        });

        if (JSON.stringify(current) === JSON.stringify(this._lastInterestedCountries)) {
            return this._lastInterestedCountries;
        }
        this._lastInterestedCountries = current;
        return current;
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
        
        return [...new Set(countries)].sort();
    }

    initializeMigrationData() {
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
        const hasInterests = this.suggestedPrograms.some(p => ['STUDY', 'MIGRATION', 'VISA', 'WORK', 'COACHING'].includes(p.type));
        if (!this.studentPrograms || hasInterests) return;

        const interests: any[] = [];
        (this.studentPrograms.study || []).forEach((p: any) => {
            interests.push({
                type: 'STUDY',
                subType: 'default',
                program: `${p.country || ''}`.trim(),
                status: '',
                sub_status: '',
                remarks: '',
                is_selected: 0,
                branch_id: null,
                department_id: null,
                assigned_to: null,
                country: p.country || '',
                applied_for: p.level || '',
                details: p.field || '',
                details2: p.intake || '',
                details3: p.year || '',
                _isSystem: false
            });
        });
        (this.studentPrograms.migration || []).forEach((p: any) => {
            interests.push({
                type: 'MIGRATION',
                subType: 'default',
                program: `${p.country || ''}`.trim(),
                status: '',
                sub_status: '',
                remarks: '',
                is_selected: 0,
                branch_id: null,
                department_id: null,
                assigned_to: null,
                country: p.country || '',
                applied_for: p.occupation || '',
                details: p.category || '',
                details2: '',
                details3: '',
                _isSystem: false
            });
        });
        (this.studentPrograms.visa || []).forEach((p: any) => {
            interests.push({
                type: 'VISA',
                subType: 'default',
                program: `${p.country || ''}`.trim(),
                status: '',
                sub_status: '',
                remarks: '',
                is_selected: 0,
                branch_id: null,
                department_id: null,
                assigned_to: null,
                country: p.country || '',
                applied_for: p.category || '',
                details: '',
                details2: '',
                details3: '',
                _isSystem: false
            });
        });
        (this.studentPrograms.work || []).forEach((p: any) => {
            interests.push({
                type: 'WORK',
                subType: 'default',
                program: `${p.country || ''}`.trim(),
                status: '',
                sub_status: '',
                remarks: '',
                is_selected: 0,
                branch_id: null,
                department_id: null,
                assigned_to: null,
                country: p.country || '',
                applied_for: p.occupation || '',
                details: '',
                details2: '',
                details3: '',
                _isSystem: false
            });
        });
        (this.studentPrograms.coaching || []).forEach((p: any) => {
            interests.push({
                type: 'COACHING',
                subType: 'default',
                program: 'COACHING',
                status: '',
                sub_status: '',
                remarks: '',
                is_selected: 0,
                branch_id: null,
                department_id: null,
                assigned_to: null,
                country: '',
                applied_for: p.course || '',
                details: p.batch || '',
                details2: '',
                details3: '',
                _isSystem: false
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

    onSave(navigateAfterSave: boolean = false, silent: boolean = false) {
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
            if (this.application.education_data && this.application.education_data[name]) {
                this.application[`has_${prefix}_edu`] = this.application.education_data[name].has_edu;
                this.application[`${prefix}_edu_level`] = this.application.education_data[name].level;
                this.application[`${prefix}_edu_field`] = this.application.education_data[name].field;
            }

            // Sync Work Years (using migration_data for work years as unified source)
            if (this.application.migration_data && this.application.migration_data[name]) {
                this.application[`${prefix}_work_years`] = this.application.migration_data[name].work_years;
            }

            // Sync Spouse fields
            if (this.application.migration_spouse_data && this.application.migration_spouse_data[name]) {
                this.application[`spouse_${prefix}_edu`] = this.application.migration_spouse_data[name].has_edu;
                this.application[`spouse_${prefix}_work`] = this.application.migration_spouse_data[name].work_years;
            }
        });

        // Map UI-only education properties into education_data JSON for saving
        if (!this.application.education_data) this.application.education_data = { additional: [] };
        this.application.education_data.highest_education_status = this.application.highest_education_status;
        this.application.education_data.highest_education_expected = this.application.highest_education_expected;
        this.application.education_data.education_country = this.application.education_country;
        this.application.education_data.spouse_edu_status = this.application.spouse_edu_status;
        this.application.education_data.spouse_edu_expected = this.application.spouse_edu_expected;
        this.application.education_data.spouse_edu_country = this.application.spouse_edu_country;
        this.application.education_data.spouse_edu_field = this.application.spouse_edu_field;
        this.application.education_data.spouse_education = this.application.spouse_education;
        this.application.education_data.language_test_list = this.application.has_language_test ? this.application.language_test_list : [];
        this.application.education_data.spouse_has_language_test = this.application.spouse_has_language_test;
        this.application.education_data.spouse_language_test_list = this.application.spouse_has_language_test ? this.application.spouse_language_test_list : [];
        this.application.education_data.admission_test_list = this.application.has_admission_test ? this.application.admission_test_list : [];

        // Map UI-only work properties into migration_data JSON for saving
        if (!this.application.migration_data) this.application.migration_data = {};
        if (!this.application.migration_data['General']) this.application.migration_data['General'] = {};
        this.application.migration_data['General'].work_experience_list = this.application.has_work_experience ? this.application.work_experience_list : [];

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

        // 2. Gather Work Experience (Only if job_title is present)
        if (this.application.has_work_experience && this.application.work_experience_list) {
            this.application.work_experience_list.forEach((w: any) => {
                if (w.job_title) {
                    work_experience_list.push({
                        country: w.employment_country || 'General',
                        job_title: w.job_title,
                        status: w.status || 'Completed',
                        start_date: w.start_date || null,
                        work_years: parseInt(w.work_years) || 0,
                        work_months: parseInt(w.work_months) || 0,
                        is_current: 1,
                        work_type: 'curr_other'
                    });
                }
            });
        }
        // Removed legacy other_work_experience_list gathering

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
                                is_current: 1,
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
                        is_current: 1,
                        work_type: 'curr_other'
                    });
                }
            });
        }
        // 2. Fixed Country Spouse Work
        if (this.application.migration_spouse_data) {
            this.migrationCountries.forEach(country => {
                const mig = this.application.migration_spouse_data[country];
                if (mig && mig.work_experience_list) {
                    mig.work_experience_list.forEach((w: any) => {
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
            relatives
        };

        this.loadingService.show();
        this.studentService.saveStudentApplication(this.studentId, data).subscribe({
            next: () => {
                this.captureSnapshot();
                if (!silent) {
                    this.dialogService.success('Application saved successfully');
                }
                if (navigateAfterSave) {
                    this.router.navigate(['/students/registration', this.studentId]);
                }
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
        if (this.hasUnsavedChanges()) {
            this.dialogService
                .confirm('You have unsaved changes. Press OK to save and go to Registration, or Cancel to go without saving.')
                .subscribe((saveAndGo: boolean) => {
                    if (saveAndGo) {
                        this.onSave(true, true);
                    } else {
                        this.router.navigate(['/students/registration', this.studentId]);
                    }
                });
            return;
        }
        this.router.navigate(['/students/registration', this.studentId]);
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



    checkAndAddOtherSuggestedProgram() {
        if (!this.suggestedPrograms) this.suggestedPrograms = [];

        // 1. Skill Assessment (NO -> ensure there is an 'OTHER' row with program = 'Skill Assessment' and _isSystem = true)
        if (this.application.has_skill_assessment === false) {
            const exists = this.suggestedPrograms.some(p => (p.type === 'OTHER' && p.program === 'Skill Assessment' || p.type === 'Skill Assessment') && p._isSystem);
            if (!exists) {
                this.addSuggestedProgram('Skill Assessment', 'Skill Assessment', true);
            }
        } else {
            const idx = this.suggestedPrograms.findIndex(p => (p.type === 'OTHER' && p.program === 'Skill Assessment' || p.type === 'Skill Assessment') && p._isSystem);
            if (idx > -1) {
                this.suggestedPrograms.splice(idx, 1);
            }
        }

        // 2. Language Test (NO -> ensure there is an 'OTHER' row with program = 'Language Test' and _isSystem = true)
        if (this.application.has_language_test === false) {
            const exists = this.suggestedPrograms.some(p => (p.type === 'OTHER' && p.program === 'Language Test' || p.type === 'Language Test') && p._isSystem);
            if (!exists) {
                this.addSuggestedProgram('Language Test', 'Language Test', true);
            }
        } else {
            const idx = this.suggestedPrograms.findIndex(p => (p.type === 'OTHER' && p.program === 'Language Test' || p.type === 'Language Test') && p._isSystem);
            if (idx > -1) {
                this.suggestedPrograms.splice(idx, 1);
            }
        }

        // 3. Admission Test (NO -> ensure there is an 'OTHER' row with program = 'Admission Test' and _isSystem = true)
        if (this.application.has_admission_test === false) {
            const exists = this.suggestedPrograms.some(p => (p.type === 'OTHER' && p.program === 'Admission Test' || p.type === 'Admission Test') && p._isSystem);
            if (!exists) {
                this.addSuggestedProgram('Admission Test', 'Admission Test', true);
            }
        } else {
            const idx = this.suggestedPrograms.findIndex(p => (p.type === 'OTHER' && p.program === 'Admission Test' || p.type === 'Admission Test') && p._isSystem);
            if (idx > -1) {
                this.suggestedPrograms.splice(idx, 1);
            }
        }

        // 4. Spouse Language Test (NO -> ensure there is an 'OTHER' row with program = 'Spouse Language Test' and _isSystem = true)
        if (this.application.spouse_has_language_test === false) {
            const exists = this.suggestedPrograms.some(p => (p.type === 'OTHER' && p.program === 'Spouse Language Test' || p.type === 'Spouse Language Test') && p._isSystem);
            if (!exists) {
                this.addSuggestedProgram('Spouse Language Test', 'Spouse Language Test', true);
            }
        } else {
            const idx = this.suggestedPrograms.findIndex(p => (p.type === 'OTHER' && p.program === 'Spouse Language Test' || p.type === 'Spouse Language Test') && p._isSystem);
            if (idx > -1) {
                this.suggestedPrograms.splice(idx, 1);
            }
        }
    }

    onLanguageTestChange() {
        this.checkAndAddOtherSuggestedProgram();
        this.onTestCompletionChange();
    }

    onAdmissionTestChange() {
        this.checkAndAddOtherSuggestedProgram();
        this.onTestCompletionChange();
    }

    onSpouseLanguageTestChange() {
        this.checkAndAddOtherSuggestedProgram();
    }

    onTestCompletionChange() {
        const hasLang = !!this.application.has_language_test;
        const hasAdm = !!this.application.has_admission_test;

        if (!hasLang && !hasAdm) {
            this.application.interested_in_lang_coaching = false;
            this.application.lang_coaching_course = '';
            this.application.expected_lang_coaching_date = '';

            this.application.interested_in_admission_coaching = false;
            this.application.admission_coaching_course = '';
            this.application.expected_admission_coaching_date = '';
        }

        this.checkAndAddOtherSuggestedProgram();
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
            if (this.application[hasKey] === true && (!this.application[listKey] || this.application[listKey].length === 0)) {
                this.addLanguageTest(target);
            } else if (this.application[hasKey] === false) {
                this.application[listKey] = [];
            }
        } else {
            if (this.application.has_admission_test === true && (!this.application.admission_test_list || this.application.admission_test_list.length === 0)) {
                this.addAdmissionTest();
            } else if (this.application.has_admission_test === false) {
                this.application.admission_test_list = [];
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
            this.application.skill_assessment_interest = null;
        }
        this.checkAndAddOtherSuggestedProgram();
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

    goBack() {
        this.router.navigate(['/students/edit', this.studentId]);
    }
}
