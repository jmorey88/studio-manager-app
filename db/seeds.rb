# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'yaml'

User.destroy_all

profile_images = YAML.load_file(Rails.root.join('config', 'sample_profile_images.yml'))
sample_lessons = YAML.load_file(Rails.root.join('config', 'sample_lesson_plans.yml'))

shuffled_profile_image_links = profile_images['profile_image_links'].shuffle
shuffled_sample_lessons = sample_lessons['sample_lesson_plans'].shuffle

# generate guest teacher

User.create_teacher!(name: "Guest Teacher",
                       email: "guest.teacher@mail.com",
                       password: "fakepassword",
                       password_confirmation: "fakepassword",
                       profile_image_url: "https://studio-manager-profile-images.s3.us-west-1.amazonaws.com/jurica-koletic-7YVZYZeITc8-unsplash.jpg")

# generate 10 students with 5 lesson plans each for guest teacher

10.times do |s|
  student_name = Faker::Name.name
  student_email = "sample.student#{s+1}@mail.com"
  student = User.create_student!(name: student_name,
                       email: student_email,
                       password: "fakepassword",
                       password_confirmation: "fakepassword",
                       teacher_id: 1,
                       profile_image_url: shuffled_profile_image_links.shift)
  5.times do |l|
    title = "sample lesson #{l+1}"
    # body = Faker::Lorem.sentence(word_count: 5)
    LessonPlan.create!(title: title,
                       body: shuffled_sample_lessons.shift,
                       student_id: student.id)
  end
end

#generate 5 teachers with 10 students each

# 5.times do |t|
#   teacher_name = Faker::Name.name
#   teacher_email = "example#{t+1}@mail.com"
#   password = "fakepassword"
#   teacher = User.create_teacher!(
#     name: teacher_name,
#     email: teacher_email,
#     password: password,
#     password_confirmation: password
#   )
#   10.times do |s|
#     student_name = Faker::Name.name
#     student_email = "example#{t+1}.#{s+1}@mail.com"
#     student = User.create_student!(name: student_name,
#                          email: student_email,
#                          password: password,
#                          password_confirmation: password,
#                          teacher_id: teacher.id)
#     5.times do |l|
#       title = "lesson#{l+1}"
#       body = Faker::Lorem.sentence(word_count: 5)
#       LessonPlan.create!(title: title,
#                          body: body,
#                          student_id: student.id)
#     end
#   end
# end