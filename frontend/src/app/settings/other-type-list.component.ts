import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { SettingsService } from '../shared/settings.service';
import { GenericMasterListComponent } from './generic-master-list.component';

@Component({
  standalone: true,
  imports: [CommonModule, GenericMasterListComponent],
  template: `
    <app-generic-master-list
      title="Other Type Management"
      description="Manage other program types for student suggested programs."
      itemName="Other Type"
      idField="other_type_id"
      [loadFn]="loadFn"
      [saveFn]="saveFn"
      [deleteFn]="deleteFn"
    ></app-generic-master-list>
  `
})
export class OtherTypeListComponent {
  loadFn = () => this.settingsService.getOtherTypes();
  saveFn = (data: any) => this.settingsService.saveOtherType(data);
  deleteFn = (id: number) => this.settingsService.deleteOtherType(id);

  constructor(private settingsService: SettingsService) {}
}
