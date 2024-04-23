import { NgModule }      from '@angular/core';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatTableModule } from '@angular/material/table';
//import { BrowserModule } from '@angular/platform-browser';
import { AppComponent }  from './app.component';
import { CommonModule } from '@angular/common';
import { MatSelectModule } from '@angular/material/select';
import { MatPaginatorModule } from '@angular/material/paginator';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatSortModule } from '@angular/material/sort';
import { FormsModule } from '@angular/forms';


@NgModule({
  imports: [
    //BrowserModule, 
    CommonModule,
    MatIconModule, 
    MatButtonModule,
    MatTableModule,
    MatSelectModule,
    MatPaginatorModule,
    BrowserAnimationsModule,
    MatSortModule,
    FormsModule
  ],
  declarations: [ AppComponent ],
  bootstrap:    [ AppComponent ]
})
export class AppModule { }