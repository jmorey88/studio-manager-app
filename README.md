# README

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

- switch user_params to teacher_params and student_params in respective controllers
- dont require password for student edit form
- switch @user for students to @student
- current_user.students def as @students
- replace students routes w/ resources: students
- move sessions_controller actions for teacher(show, edit, update) to new teacher controller...maybe resources: teachers in routes
<!-- - add profile action in application_controller -->
  add profile link that goes to teacher show
-lesson plan controller
  has id and student id

Questions for Ross
- 