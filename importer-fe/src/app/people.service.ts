import { HttpClient, HttpParams } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Observable, map, catchError, throwError } from "rxjs";
import { TestData } from "./models/people-data.model";

export interface PeopleData {
    people: TestData[];
}

@Injectable({
    providedIn: 'root',
})

export class PeopleService {

    constructor(private http: HttpClient) {}

    findAll(offset: number, limit: number, sortColumn: string, sortDirection: string, filterInput: string): Observable<PeopleData>{
        let params = new HttpParams();
    
        params = params.append('offset', String(offset));
        params = params.append('limit', String(limit));
        params = params.append('sort_column', String(sortColumn));
        params = params.append('sort_direction', String(sortDirection));
        params = params.append('filter_text', String(filterInput))
    
        return this.http.get<PeopleData>('http://localhost:3000/people', {params}).pipe(
          map((peopleData: PeopleData) => peopleData),
          catchError((err) => throwError(() => err))
        )
    
    }

    totalRecordCount() {
        return this.http.get<number>('http://localhost:3000/people/count_all').pipe(
            map((count: number) => count),
            catchError((err) => throwError(() => err))
        )
    }
}