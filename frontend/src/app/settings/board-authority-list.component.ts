import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { SettingsService } from '../shared/settings.service';
import { GenericMasterListComponent } from './generic-master-list.component';

@Component({
  selector: 'app-board-authority-list',
  standalone: true,
  imports: [CommonModule, GenericMasterListComponent],
  template: `
    <app-generic-master-list
      title="Board / Authority Management"
      description="Manage authorities for Skill Assessment (e.g. WES, ACS, Engineers Australia)."
      itemName="Authority"
      idField="id"
      [loadFn]="loadFn"
      [saveFn]="saveFn"
      [deleteFn]="deleteFn"
    ></app-generic-master-list>
  `
})
export class BoardAuthorityListComponent {
  loadFn = () => this.settingsService.getBoardAuthorities();
  saveFn = (data: any) => this.settingsService.saveBoardAuthority(data);
  deleteFn = (id: number) => this.settingsService.deleteBoardAuthority(id);

  constructor(private settingsService: SettingsService) {}
}
