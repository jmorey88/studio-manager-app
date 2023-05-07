# frozen_string_literal: true

FactoryBot.define do
  factory :lesson_plan do
    title { 'Title' }
    body { 'Body' }
    student
  end
end
