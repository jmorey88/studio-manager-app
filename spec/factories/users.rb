# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'First Last' }
    email { "first.last.#{Time.now.to_f}@gmail.com" }
    password { 'fakepassword' }
    password_confirmation { 'fakepassword' }

    factory :teacher do
      roles { User::TEACHER_ROLE }
    end
    factory :student do
      roles { User::STUDENT_ROLE }
      teacher
    end
  end
end
