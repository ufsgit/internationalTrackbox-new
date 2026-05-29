import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { API_CONFIG } from './constants';


@Injectable({
    providedIn: 'root'
})
export class UserService {
    private apiUrl = `${API_CONFIG.BASE_URL}/api`;


    constructor(private http: HttpClient) { }

    saveUser(userData: any): Observable<any> {
        return this.http.post(`${this.apiUrl}/users`, userData);
    }

    getUsers(): Observable<any> {
        return this.http.get(`${this.apiUrl}/users`);
    }

    getStaffList(): Observable<any> {
        return this.http.get(`${this.apiUrl}/users/list`);
    }

    getUser(id: number): Observable<any> {
        return this.http.get(`${this.apiUrl}/users/${id}`);
    }

    getBranches(): Observable<any> {
        return this.http.get(`${this.apiUrl}/branches`);
    }

    getDepartments(): Observable<any> {
        return this.http.get(`${this.apiUrl}/departments`);
    }

    getBranchDepartments(branchId: number): Observable<any[]> {
        return this.http.get<any[]>(`${this.apiUrl}/branches/${branchId}/departments`);
    }

    getUserProcessAssignments(userId: number): Observable<any> {
        return this.http.get(`${this.apiUrl}/users/${userId}/process-assignments`);
    }

    saveUserProcessAssignments(userId: number, assignments: any[]): Observable<any> {
        return this.http.post(`${this.apiUrl}/users/${userId}/process-assignments`, { assignments });
    }
}
