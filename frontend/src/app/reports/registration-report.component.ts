import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { StudentService } from '../shared/student.service';
import { SettingsService } from '../shared/settings.service';
import { UserService } from '../shared/user.service';
import { LoadingService } from '../shared/loading.service';

@Component({
    selector: 'app-registration-report',
    standalone: true,
    imports: [CommonModule, FormsModule, RouterModule],
    templateUrl: './registration-report.component.html',
    styleUrls: ['./registration-report.component.css']
})
export class RegistrationReportComponent implements OnInit {

    // Pagination
    currentPage = 1;
    pageSize = 10;
    totalRecords = 0;
    totalPages = 0;

    // Data
    reportData: any[] = [];
    branches: any[] = [];
    users: any[] = [];

    // Filters
    filters = {
        fromDate: '',
        toDate: '',
        search: '',
        branchId: null,
        staffId: null
    };

    constructor(
        private studentService: StudentService,
        private settingsService: SettingsService,
        private userService: UserService,
        private loadingService: LoadingService
    ) { }

    ngOnInit() {
        this.setDefaultDates();
        this.loadLookups();
        this.runReport();
    }

    setDefaultDates() {
        const today = new Date().toISOString().split('T')[0];
        this.filters.fromDate = today;
        this.filters.toDate = today;
    }

    loadLookups() {
        this.loadingService.show();
        this.settingsService.getBranches().subscribe({
            next: (data) => { this.branches = data; this.loadingService.hide(); },
            error: () => this.loadingService.hide()
        });

        this.loadingService.show();
        this.userService.getUsers().subscribe({
            next: (data) => { this.users = data; this.loadingService.hide(); },
            error: () => this.loadingService.hide()
        });
    }

    runReport(page: number = 1) {
        this.currentPage = page;

        const payload = {
            ...this.filters,
            page: this.currentPage,
            limit: this.pageSize
        };

        this.loadingService.show();

        this.studentService.getRegistrationReport(payload).subscribe({
            next: (res: any) => {
                this.reportData = res.data || [];
                this.totalRecords = res.total || 0;
                this.totalPages = Math.ceil(this.totalRecords / this.pageSize);
                this.loadingService.hide();
            },
            error: (err) => {
                console.error('Report Error:', err);
                this.loadingService.hide();
            }
        });
    }

    nextPage() {
        if (this.currentPage < this.totalPages) {
            this.runReport(this.currentPage + 1);
        }
    }

    prevPage() {
        if (this.currentPage > 1) {
            this.runReport(this.currentPage - 1);
        }
    }

    goToPage(page: number) {
        this.runReport(page);
    }
}
