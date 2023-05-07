# frozen_string_literal: true

# require "rails_helper"

RSpec.describe LessonPlan, type: :model do
  context 'with attributes' do
    it 'title' do
      expect(create(:lesson_plan, title: 'Title'))
        .to have_attributes(title: 'Title')
    end
    it 'body' do
      expect(create(:lesson_plan, body: 'Body'))
        .to have_attributes(body: 'Body')
    end
    it 'student_id' do
      student = create(:student)
      expect(create(:lesson_plan, student_id: student.id))
        .to have_attributes(student_id: student.id)
    end
  end

  context 'with validations' do
    subject { create(:lesson_plan) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(50) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_most(500) }
    it { is_expected.to validate_presence_of(:student_id) }
  end
end
