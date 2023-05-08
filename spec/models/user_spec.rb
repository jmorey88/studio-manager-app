# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:teacher) { create(:teacher) }
  let(:student) { create(:student) }

  context 'with attributes' do
    it 'name' do
      expect(create(:teacher, name: 'Name')).to have_attributes(name: 'Name')
    end

    it 'email' do
      expect(build(:user, email: 'a@b.c')).to have_attributes(email: 'a@b.c')
    end

    it 'roles' do
      expect(build(:user, roles: 'teacher')).to have_attributes(roles: 'teacher')
    end

    it 'profile image' do
      expect(build(:user, profile_image_url: 'https://image.com/name.jpg')).to have_attributes(profile_image_url: 'https://image.com/name.jpg')
    end
  end

  context 'with validations' do
    subject { create(:teacher) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_length_of(:email).is_at_most(250) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(8).on(%i[create update]) }
    it { should validate_presence_of(:profile_image_url).allow_nil }

    it 'requires roles to be valid' do
      expect(build(:user, roles: 'invalid')).not_to be_valid
      expect(build(:user, roles: User::TEACHER_ROLE)).to be_valid
      expect(build(:user, roles: User::STUDENT_ROLE, teacher: subject)).to be_valid
    end

    it 'requires email to match regex' do
      expect(build(:user, email: 'bad_email_address')).to_not be_valid
      expect(build(:teacher, email: 'good@email.address')).to be_valid
    end

    context 'with student role' do
      it 'requires presence of teacher' do
        new_student = build(:student, teacher: nil)
        expect(new_student).to_not be_valid
        expect { new_student.save! }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Teacher Required for student user.')
      end
    end

    context 'with teacher role' do
      it 'doesn\'t allow presence of teacher' do
        expect(build(:teacher, teacher: subject)).to_not be_valid
      end
    end

    it "assigns default profile image if nil" do
      new_user = build(:user, profile_image_url: nil)
      new_user.save
      expect(new_user.profile_image_url).to eq 'https://studio-manager-profile-images.s3.us-west-1.amazonaws.com/Default_pfp.svg'
    end
  end

  describe 'scopes' do
    before do
      # Create some users w/ different roles:
      create(:teacher)
      create(:student)
    end

    it 'filters teachers correctly' do
      expect(described_class.teachers.count).to eq 2
    end

    it 'filters students correctly' do
      expect(described_class.students.count).to eq 1
    end
  end

  describe '#teacher?' do
    it 'returns true for a teacher user' do
      expect(teacher.teacher?).to be true
    end

    it 'returns false for a non teacher' do
      expect(student.teacher?).to be false
    end
  end

  describe '#student?' do
    it 'returns true for an studet user' do
      expect(student.student?).to be true
    end

    it 'returns false for a non student' do
      expect(teacher.student?).to be false
    end
  end

  describe '::create_teacher' do
    it 'creates a new user with teacher role' do
      user = User.create_teacher!(name: 'Guest Teacher',
                                  email: 'guest.teacher@mail.com',
                                  password: 'fakepassword',
                                  password_confirmation: 'fakepassword')
      expect(user).to be_an_instance_of(User)
      expect(user.id).to_not be_nil
      expect(user.roles).to eq User::TEACHER_ROLE
    end
  end

  describe '::create_student' do
    it 'creates a new user with student role' do
      user = User.create_student!(name: 'Guest Teacher',
                                  email: 'guest.teacher@mail.com',
                                  password: 'fakepassword',
                                  password_confirmation: 'fakepassword',
                                  teacher_id: teacher.id)
      expect(user).to be_an_instance_of(User)
      expect(user.id).to_not be_nil
      expect(user.roles).to eq User::STUDENT_ROLE
    end
  end

  describe 'associations' do
    it 'students can have a teacher' do
      student.teacher = teacher
      student.save!
      expect(student.teacher_id).to eq teacher.id
    end

    it 'teachers can have students ' do
      teacher.students << student
      teacher.save!
      expect(teacher.students.count).to eq 1
      expect(teacher.students.first.id).to eq student.id
    end

    it 'students can have lesson plans' do
      plan = create(:lesson_plan)
      student.lesson_plans << plan
      student.save!
      expect(student.lesson_plans.count).to eq 1
      expect(student.lesson_plans.first.id).to eq plan.id
    end
  end
end
