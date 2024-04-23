import { Component, OnInit } from '@angular/core';
import { Observable, catchError, map, throwError } from 'rxjs';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatTableModule } from '@angular/material/table';
import { HttpClient, HttpParams} from '@angular/common/http';
//import { PeopleData } from '../app/models/people-data.model';
import { PeopleService, PeopleData } from './people.service';
import { NgIf } from '@angular/common';
import { MatPaginator, MatPaginatorModule, PageEvent } from '@angular/material/paginator';
import { MatSortModule, Sort } from '@angular/material/sort';
import { FormsModule } from '@angular/forms';



@Component({
  selector: 'app-root',
  standalone: true,
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
  imports: [MatTableModule, MatIconModule, MatButtonModule, MatPaginatorModule, MatSortModule, NgIf, FormsModule]
})


export class AppComponent  implements OnInit {

  fileName = '';
  dataSource: PeopleData;
  displayedColumns = ["first_name", "last_name", "locations", "gender", "weapon", "vehicle", "affiliations", "species"];
  total_count = 0;
  pageSizeOptions = [5, 10];
  page: number = 0;
  size: number = 10;
  filterInput: string = '' ;
  sortColumn: string = "first_name";
  sortDirection: string = "asc";

  constructor(
    private http: HttpClient,
    private peopleService: PeopleService
  ) {}

  onFileSelected(event:any) {
    const file:File = event.target.files[0]

    if (file) {

      this.fileName = file.name;
      const formData = new FormData();
      formData.append("file", file);

      const upload$ = this.http.post("http://localhost:3000/people/import_person_csv", formData);
      upload$.subscribe(() => this.peopleService.findAll(this.page, this.size, this.sortColumn, this.sortDirection, this.filterInput).pipe(
        map((peopleData: PeopleData) => this.dataSource = peopleData)
      ).subscribe());
    }
  }

  ngOnInit(): void {
    this.initDataSource();
    
  }

  initDataSource() {
    this.peopleService.findAll(this.page, this.size, this.sortColumn, this.sortDirection, this.filterInput).pipe(
      map((peopleData: PeopleData) => this.dataSource = peopleData)
    ).subscribe();
  }

  onPaginationChange(event: PageEvent){
    this.page = event.pageIndex;
    this.size = event.pageSize;

    this.peopleService.findAll(this.page, this.size, this.sortColumn, this.sortDirection, this.filterInput).pipe(
      map((peopleData: PeopleData) => this.dataSource = peopleData)
    ).subscribe();
  }

  onSortChange(sort: Sort): void {
    this.sortColumn = sort.active;
    this.sortDirection = sort.direction;


    this.peopleService.findAll(this.page, this.size, this.sortColumn, this.sortDirection, this.filterInput).pipe(
      map((peopleData: PeopleData) => this.dataSource = peopleData)
    ).subscribe();

  }

  onSubmit() {
    this.peopleService.findAll(this.page, this.size, this.sortColumn, this.sortDirection, this.filterInput).pipe(
      map((peopleData: PeopleData) => this.dataSource = peopleData)
    ).subscribe();
  }


}
