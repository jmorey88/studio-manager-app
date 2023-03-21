# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all

# generate 5 teachers with 10 students each

5.times do |t|
  teacher_name = "teacher#{t+1}"
  teacher_email = "#{teacher_name}@mail.com"
  password = "password"
  teacher_role = "teacher"
  User.create!(name: teacher_name,
               email: teacher_email,
               password: password,
               password_confirmation: password,
               roles: teacher_role)
  10.times do |s|
    student_name = "student#{s+1}.#{t+1}"
    student_email = "#{student_name}@mail.com"
    student_role = "student"
    teacher_id = t+1
    User.create!(name: student_name,
                 email: student_email,
                 password: password,
                 password_confirmation: password,
                 roles: student_role,
                 teacher_id: teacher_id)
  end
end


