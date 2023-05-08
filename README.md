# Studio Manager App

The Studio Manager App is a Rails application that allows teacher users to 
create an account, manage students, and create lesson plans.

## Features

- User authentication: Teachers can sign up, log in, and log out of the app.
- Student management: Teachers can create, view, edit, and 
  delete student profiles.
- Lesson plan creation: Teachers can create, view, edit, and delete lesson plans 
  associated with their students.

## Getting Started

To run the Studio Manager App locally, follow these steps:

1. Make sure you have Ruby 3.1.2 installed.
2. Clone this repository to your local machine.
3. Install the required gems by running the following command: bundle install
4. Set up the database by running the following command: rails db:seed
5. Start the Rails server: rails server
6. Open your web browser and visit `http://localhost:3000`.

## Usage

- For Guest experience select Guest Login to view app with sample teacher, 
  student and lesson plan data 
- Sign up as a teacher user to create an account.
- Log in with your credentials to access your dashboard.
- From the dashboard, you can manage your students and create lesson plans.
- View, edit, or delete student profiles and lesson plans from their 
  respective pages.

## Screen Shots

- ![home page screenshot](https://studio-manager-profile-images.s3.us-west-1.amazonaws.com/screenshots/StudioManagerScreenshots/home_page_screenshot.png)
- ![teacher show screenshot](https://studio-manager-profile-images.s3.us-west-1.amazonaws.com/screenshots/StudioManagerScreenshots/teacher_show_screenshot.png)
- ![student index screenshot](https://studio-manager-profile-images.s3.us-west-1.amazonaws.com/screenshots/StudioManagerScreenshots/student_index_screenshot.png)
- ![student show screenshot](https://studio-manager-profile-images.s3.us-west-1.amazonaws.com/screenshots/StudioManagerScreenshots/student_show_sceenshot.png)
- ![lesson plan index screenshot](https://studio-manager-profile-images.s3.us-west-1.amazonaws.com/screenshots/StudioManagerScreenshots/lessonplan_index_screenshot.png)

## File Structure

The Studio Manager App follows a typical Rails file structure. Here are some of 
the key files and directories:

- `app/controllers`: Contains the controllers for managing different actions.
- `app/models`: Contains the models for users, students, and lesson plans.
- `app/views`: Contains the view templates for rendering HTML.
- `Gemfile`: Lists the required gems and their versions.

## Dependencies

The Studio Manager App has the following dependencies:

- Ruby 3.1.2
- Rails 7.0.4
- SQLite 1.4

For a complete list of dependencies, please refer to the `Gemfile` in the 
root directory.

## Contributing

Contributions to the Studio Manager App are welcome! If you find any issues or 
have suggestions for improvements, please open an issue or submit 
a pull request.



<!-- # README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

TODO List


- finish specs
- finish seed data
  images
  lesson_plan text
    -generated through chat GPT
- polish styling
- cleanup/edit code
  - google how to run rubocop autofix
    - start from clean working branch first
- push to heroku
- think about domain name
  - look at Route53 for register domain name
- polish/write ReadMe
  - look at examples
  - include images
  - include link to demo app
    - screenshot app
    - put images in S3
    - link to with markdown -->





