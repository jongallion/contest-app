# Contest App

## Project Description

This app is meant to be a code example. 
The code is pulled from another app that provides user authentication. 
Users are registered for the contest when they sign in, if the user is eligible.

Methods that made calls to other parts of the app have been modified to return a 
value without making the call. Comments have been added to point those changes.

Content and Styling have not been included as part of the app.

### To be eligible:
* The current date is within the contest date range. 
* The user's membership starts before the beginning of the contest.
* The user's membership ends after the end of the contest.

### Technical requirements:
* The app will register the user when they sign into the app.
* The app will only register the user once a day.
* The app will show the user the contest interstitial once a week.
* The app sets a cookie to minimize calls for registering the user.
* The app will not register user more than once a day, even if the cookie is deleted.
* THe app provides a simple admin to download the results by day or for the entire contest.

## Project Setup

### Ruby version
Make sure you have Ruby 2.6.0 

```Shell
gem install bundler
bundle install
```

### Configure Database
Engage the MySQL console: `sudo mysql`, then run:
```SQL
create DATABASE contest;
create DATABASE contest_test;
create USER 'contest_dev'@'localhost' IDENTIFIED BY 'db_password';
GRANT ALL ON contest.* TO 'contest_dev'@'localhost';
GRANT ALL ON contest_test.* TO 'contest_dev'@'localhost';
flush privileges;
```
Create or edit `.env.test` and add: `DB_DATABASE=contest_test`


### Update Database
Setup the database and load seed data:
```Shell
bundle exec rake db:setup
```
```Shell
RAILS_ENV=test bundle exec rake db:reset
```
