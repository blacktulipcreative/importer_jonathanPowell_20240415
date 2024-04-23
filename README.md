# README

This is code for a CSV Importer. The CSV file can be found in:

```
/db

```
To view/delete records using the backend, you can do this using the rails console and then running your function in there (e.g. Person.destroy_all)

All front end and backend code can be found in the same git repository.

## The following files have code in them:

### Backend:

```
app/models: person, affiliation, location
app/controllers: people_controller, affiliations_controller, locations_controller, applications_controller
db/migrate
specs/models
config/routes
Gemfile/Gemfile.lock
```
### Frontend:

```
./importer-fe/src:

./app/models
./app/app.components.html
./app/app.component.ts
./app/app.module.ts
./app/people.service.ts
```

## Backend

### Database

The database used is the default SQLite3 database. My knowledge in Postgresql but I felt the use of the default SQLite3 database would ensure minimal installation from the reviewer's end.

### Backend Installation

The backend has been developed in RUBY ON RAILS. 

```
Ruby Version: 3.1.2
Rails Version: 7.0.8.1
```
To install the backend, 

1. open /importer_jonathanPowell_20240415
2. Install the gems

```
bundle install
```
3. You MAY have to run the migration on the first run to build the database. As I am not used to SQLite3 I am unsure whether the database will come pre-built within this repository. To do this, run:

```
rake db:migrate
```

3. Run the server

```
rails s
```

## Frontend

The front end is coded in ANGULAR. It can be found in:

```
./importer-fe
```
### Installation and Run

1. Open a new terminal
2. Open the following directory

```
cd /importer_jonathanPowell_20240415/importer-fe
```
3. Install the required nodes, including Angular

```
npm install

```
My current versions are:

```
Node : 20.12.2
NPM: 10.5.0
Angular: 17.3.4
```
4. Once installed, run the app

```
npm start

```

You can access the app through the ollowing address:

```
http://localhost:4200

```
## Using the App

There are 3 parts to this app. When you load the screen you will see:

a) The file upload box (including button to run import)
b) filter box with button next to it labeled "Filter"

Once the data is imported in, the data will show up in 

c) a data table

To import the data in:
```
1. Click on the purple button with the paperclip
2. Choose the CSV file to import in
```

Only a csv can be added to the file upload. This CSV can be found in the ```/db``` folder

Once the data has been imported in, you can do the following:
```
1) Sort the columns in ascending and descending order
2) Change the number of items per page to 5 or 10 (10 is the max)
3) Paginate through the data
4) Filter the data
```

To filter the data:

```
1) type a word in the filter box
2) press filter
```

## Testing

Testing is run using the RSPEC. The test files can be found in "./spec/models"

Run:

```
bundle rspec exec
```