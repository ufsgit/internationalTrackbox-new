import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { forkJoin } from 'rxjs';
import { UserService } from '../shared/user.service';
import { SettingsService } from '../shared/settings.service';

interface ProcessState {
  enabled: boolean;
  countries: { id: number; name: string; selected: boolean }[];
  selectAll: boolean;
}

@Component({
    selector: 'app-user-process-assignment',
    standalone: true,
    imports: [CommonModule, FormsModule],
    templateUrl: './user-process-assignment.component.html',
    styleUrls: ['./user-process-assignment.component.css']
})
export class UserProcessAssignmentComponent implements OnInit {
    userId: number | null = null;
    userDetails: any = null;
    allCountries: any[] = [];
    allBranches: any[] = [];
    allDepartments: any[] = [];
    loading = true;
    saving = false;
    saveSuccess = false;
    saveError = '';

    // General processes (no country)
    generalProcesses = [
        'Coaching',
        'Language',
        'Admission',
        'Skill Assessment',
        'Education Loan',
        'Ticketing',
        'Forex'
    ];

    // Country-based processes
    countryProcesses = ['Study', 'Migration', 'Visa', 'Work'];

    // State maps
    generalState: { [key: string]: boolean } = {};
    countryState: { [key: string]: ProcessState } = {};

    constructor(
        private route: ActivatedRoute,
        private router: Router,
        private userService: UserService,
        private settingsService: SettingsService
    ) {}

    ngOnInit() {
        this.route.queryParams.subscribe(params => {
            this.userId = params['id'] ? parseInt(params['id']) : null;
            if (!this.userId) {
                this.router.navigate(['/users']);
                return;
            }
            this.initState();
            this.loadData();
        });
    }

    initState() {
        // Init general
        for (const p of this.generalProcesses) {
            this.generalState[p] = false;
        }
        // Country processes initialised after countries load
    }

    loadData() {
        this.loading = true;

        // Load branches, departments, and countries in parallel first
        forkJoin({
            branches: this.userService.getBranches(),
            departments: this.userService.getDepartments(),
            countries: this.settingsService.getCountries()
        }).subscribe({
            next: ({ branches, departments, countries }: any) => {
                this.allBranches = branches;
                this.allDepartments = departments;
                this.allCountries = countries;

                // Init country process states
                for (const p of this.countryProcesses) {
                    // console.log(countries);
                    this.countryState[p] = {
                        enabled: false,
                        selectAll: false,
                        countries: countries.map((c: any) => ({
                            id: c.country_id,
                            name: c.name,
                            selected: false
                        }))
                    };
                }
                // console.log(this.countryState)

                // Now load user details
                this.userService.getUser(this.userId!).subscribe({
                    next: (data: any) => {
                        const u = data.user;
                        // Resolve branch and department names from IDs
                        const branch = branches.find((b: any) => b.branch_id === u.branch_id);
                        const dept = departments.find((d: any) => d.department_id === u.department_id);
                        this.userDetails = {
                            ...u,
                            branch_name: u.branch_name || (branch ? branch.branch_name : ''),
                            department_name: u.department_name || (dept ? dept.department_name : '')
                        };

                        // Load existing assignments
                        this.userService.getUserProcessAssignments(this.userId!).subscribe({
                            next: (assignments: any[]) => {
                                this.applyAssignments(assignments);
                                this.loading = false;
                            },
                            error: (err: any) => {
                                console.error('Error loading assignments:', err);
                                this.loading = false;
                            }
                        });
                    },
                    error: (err: any) => {
                        console.error('Error loading user:', err);
                        this.loading = false;
                    }
                });
            },
            error: (err: any) => {
                console.error('Error loading lookups:', err);
                this.loading = false;
            }
        });
    }

    applyAssignments(assignments: any[]) {
        for (const a of assignments) {
            const proc = a.process_name;

            // General processes
            if (this.generalProcesses.includes(proc)) {
                this.generalState[proc] = true;
            }

            // Country-based processes
            if (this.countryProcesses.includes(proc) && this.countryState[proc]) {
                this.countryState[proc].enabled = true;
                if (a.country_id) {
                    const country = this.countryState[proc].countries.find(c => c.id === a.country_id);
                    if (country) country.selected = true;
                }
            }
        }

        // Sync selectAll state
        for (const p of this.countryProcesses) {
            this.syncSelectAll(p);
        }
    }

    onCountryProcessToggle(process: string) {
        const state = this.countryState[process];
        if (!state.enabled) {
            // Deselect all countries when process disabled
            state.countries.forEach(c => c.selected = false);
            state.selectAll = false;
        }
    }

    onSelectAllToggle(process: string) {
        const state = this.countryState[process];
        state.countries.forEach(c => c.selected = state.selectAll);
    }

    onCountryToggle(process: string) {
        this.syncSelectAll(process);
    }

    syncSelectAll(process: string) {
        const state = this.countryState[process];
        if (!state.countries.length) return;
        state.selectAll = state.countries.every(c => c.selected);
    }

    getSelectedCountryCount(process: string): number {
        return this.countryState[process]?.countries.filter(c => c.selected).length ?? 0;
    }

    buildPayload(): any[] {
        const assignments: any[] = [];

        // General
        for (const p of this.generalProcesses) {
            if (this.generalState[p]) {
                assignments.push({ process_name: p, country_id: null });
            }
        }

        // Country-based
        for (const p of this.countryProcesses) {
            const state = this.countryState[p];
            if (state?.enabled) {
                const selected = state.countries.filter(c => c.selected);
                if (selected.length > 0) {
                    for (const country of selected) {
                        assignments.push({ process_name: p, country_id: country.id });
                    }
                } else {
                    // Process enabled but no country selected — save with null country
                    assignments.push({ process_name: p, country_id: null });
                }
            }
        }

        return assignments;
    }

    save() {
        this.saving = true;
        this.saveSuccess = false;
        this.saveError = '';

        const assignments = this.buildPayload();

        this.userService.saveUserProcessAssignments(this.userId!, assignments).subscribe({
            next: () => {
                this.saving = false;
                this.saveSuccess = true;
                setTimeout(() => this.saveSuccess = false, 3000);
            },
            error: (err: any) => {
                this.saving = false;
                this.saveError = err?.error?.error || 'Failed to save. Please try again.';
            }
        });
    }

    cancel() {
        this.router.navigate(['/users']);
    }
}
