# Studio Manager App

The Studio Manager App is a Rails application that allows teacher users to 
create an account, manage students, and create lesson plans.

## Features

- User authentication: Teachers can sign up, log in, and log out of the app.
- Student management: Teachers can create, view, edit, and 
  delete student profiles.
- Lesson plan creation: Teachers can create, view, edit, and delete lesson plans 
  associated with their students.

## Testing

The Studio Manager App uses RSpec for testing.  A comprehensive suite of tests was implemented to ensure the stability and correctness of the application. These tests cover models, controllers, and features. To check the tests, run the following command: `bundle exec rspec`

## User Authentication

The Studio Manager App implements user authentication using the bcrypt gem. The following steps were taken to achieve user authentication:

1. Sessions Controller: The `SessionsController` handles the login and logout functionality. It includes the following actions:
   - `signup`: Renders the signup form.
   - `create_teacher`: Creates a new user with the teacher role upon successful signup.
   - `login`: Renders the login form.
   - `create_session`: Authenticates the user and creates a session upon successful login.
   - `destroy`: Destroys the session and logs out the user.

2. Application Helper: The `ApplicationHelper` module includes helper methods for user authentication:
   - `current_user`: Retrieves the currently logged-in user based on the `user_id` stored in the session.
   - `logged_in?`: Checks if a user is logged in by verifying the presence of a current user.

By using the `current_user` and `logged_in?` methods provided by the `ApplicationHelper`, user authentication is implemented throughout the application.

<!-- ## Faker Gem

The Faker gem was untilized to generate realistic and randomized data for student profiles and lesson plans. This allows for a more dynamic and diverse testing and development environment. Faker provides a wide range of data types and methods for generating realistic fake data. To learn more about Faker, visit [the Faker GitHub repository](https://github.com/faker-ruby/faker). -->


## Getting Started

To run the Studio Manager App locally, follow these steps:

1. Make sure you have Ruby 3.1.2 installed.
2. Clone this repository to your local machine.
3. Install the required gems by running the following command: bundle install
4. Set up the database by running the following command: rails db:seed
5. Start the Rails server: rails server
6. Open your web browser and visit `http://localhost:3000`.

## Database Setup

To set up the database for this project, follow the steps below:

### Prerequisites

- Ensure that you have SQLite3 installed on your local machine.

### Database Configuration

1. Open the terminal and navigate to the project's root directory.

2. Open the `config/database.yml` file and configure the database settings according to your setup:



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
  homepage

- ![teacher show screenshot](https://studio-manager-profile-images.s3.us-west-1.amazonaws.com/screenshots/StudioManagerScreenshots/teacher_show_screenshot.png)
  Teacher's Profile

- ![student index screenshot](https://studio-manager-profile-images.s3.us-west-1.amazonaws.com/screenshots/StudioManagerScreenshots/student_index_screenshot.png)
  Teacher's list of students

- ![student show screenshot](https://studio-manager-profile-images.s3.us-west-1.amazonaws.com/screenshots/StudioManagerScreenshots/student_show_sceenshot.png)
  Student's Profile

- ![lesson plan index screenshot](https://studio-manager-profile-images.s3.us-west-1.amazonaws.com/screenshots/StudioManagerScreenshots/lessonplan_index_screenshot.png)
  Student's Lesson Plan list

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

## Planned Enhancements
While the project provides a solid foundation, there are planned enhancements to expand its capabilities. The following functionalities are currently possibilities for future development:

1. **Student Login:** Students will have the ability to log in to their accounts and access their individual profiles.

2. **Practice Logs:** Students will be able to create practice logs, enabling them to track their practice sessions and monitor their progress.

3. **Audio Recordings:** Students will have the option to upload audio recordings associated with their lesson plans, allowing teachers to provide feedback and evaluate their performance.

These planned enhancements aim to enrich the learning experience and provide a more comprehensive music education platform.

Please note that as an educational project, the codebase may contain certain areas that require refactoring or improvement. Contributions and suggestions are welcome to help enhance the project further.

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



