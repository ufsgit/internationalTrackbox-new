import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { SettingsService } from '../shared/settings.service';
import { GenericMasterListComponent } from './generic-master-list.component';
import { ActivatedRoute } from '@angular/router';

@Component({
  standalone: true,
  imports: [CommonModule, GenericMasterListComponent],
  template: `
    <div class="category-selector-container mb-4">
      <div class="category-tabs">
        <button [class.active]="selectedCategory === 'coaching'" (click)="setCategory('coaching')">Course</button>
        <button [class.active]="selectedCategory === 'admission'" (click)="setCategory('admission')">Admission Course</button>
        <button [class.active]="selectedCategory === 'language'" (click)="setCategory('language')">Language Course</button>
      </div>
    </div>

    <app-generic-master-list
      [title]="currentConfig.title"
      [description]="currentConfig.description"
      [itemName]="currentConfig.itemName"
      [idField]="currentConfig.idField"
      [loadFn]="currentConfig.loadFn"
      [saveFn]="currentConfig.saveFn"
      [deleteFn]="currentConfig.deleteFn"
    ></app-generic-master-list>
  `,
  styles: [`
    .category-tabs {
      display: flex;
      gap: 10px;
      border-bottom: 1px solid #e2e8f0;
      padding-bottom: 10px;
    }
    .category-tabs button {
      padding: 8px 16px;
      border: 1px solid #e2e8f0;
      background: white;
      border-radius: 6px;
      cursor: pointer;
      font-weight: 500;
      color: #64748b;
      transition: all 0.2s;
    }
    .category-tabs button:hover {
      background: #f8fafc;
      border-color: #cbd5e1;
    }
    .category-tabs button.active {
      background: #2563eb;
      color: white;
      border-color: #2563eb;
      box-shadow: 0 2px 4px rgba(37, 99, 235, 0.2);
    }
  `]
})
export class CoachingCourseListComponent {
  selectedCategory: 'coaching' | 'admission' | 'language' = 'coaching';

  configs = {
    coaching: {
      title: 'Coaching Course Management',
      description: 'Manage courses for the Coaching program (e.g. IELTS, TOEFL).',
      itemName: 'Course',
      idField: 'course_id',
      loadFn: () => this.settingsService.getCoachingCourses(),
      saveFn: (data: any) => this.settingsService.saveCoachingCourse(data),
      deleteFn: (id: number) => this.settingsService.deleteCoachingCourse(id)
    },
    admission: {
      title: 'Admission Test Management',
      description: 'Manage options for Admission tests like GMAT, GRE, SAT.',
      itemName: 'Admission Test',
      idField: 'id',
      loadFn: () => this.settingsService.getAdmissionCourses(),
      saveFn: (data: any) => this.settingsService.saveAdmissionCourse(data),
      deleteFn: (id: number) => this.settingsService.deleteAdmissionCourse(id)
    },
    language: {
      title: 'Language Test Management',
      description: 'Manage options for Language tests like IELTS, PTE, TOEFL.',
      itemName: 'Language Test',
      idField: 'id',
      loadFn: () => this.settingsService.getLanguageCourses(),
      saveFn: (data: any) => this.settingsService.saveLanguageCourse(data),
      deleteFn: (id: number) => this.settingsService.deleteLanguageCourse(id)
    }
  };

  get currentConfig() {
    return this.configs[this.selectedCategory];
  }

  setCategory(category: 'coaching' | 'admission' | 'language') {
    this.selectedCategory = category;
  }

  constructor(private settingsService: SettingsService, private route: ActivatedRoute) {
    this.route.url.subscribe(url => {
      const path = url[url.length - 1]?.path;
      if (path === 'course-admission') this.selectedCategory = 'admission';
      else if (path === 'course-language') this.selectedCategory = 'language';
      else this.selectedCategory = 'coaching';
    });
  }
}
