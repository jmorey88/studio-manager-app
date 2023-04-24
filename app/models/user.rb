# frozen_string_literal: true

# This Model is for users that can be either teachers or students
class User < ApplicationRecord
  

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i
  STUDENT_ROLE = 'student'
  TEACHER_ROLE = 'teacher'
  ROLES = [STUDENT_ROLE, TEACHER_ROLE].freeze

  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 250 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validate :ensure_valid_roles
  validate :valid_teacher_id?
  validates :password, 
            presence: true, 
            length: { minimum: 8 },
            if: :password_digest_changed?, 
            on: [:create, :update] 

  def ensure_valid_roles
    return if ROLES.include? roles

    errors.add(:roles, "must include valid role: #{ROLES}")
  end

  def valid_teacher_id?
    if student? && teacher_id.nil?
      errors.add(:teacher_id, 'required for student user')
    elsif teacher? && !teacher_id.nil?
      errors.add(:teacher_id, 'relation should be null for teacher user')
    end
  end

  # find all students
  scope :students, -> { where(roles: STUDENT_ROLE) }

  # find all teachers
  scope :teachers, -> { where(roles: TEACHER_ROLE) }

  # TODO: limit this association to teacher users only 
  has_many :students, class_name: 'User',
                      foreign_key: 'teacher_id'

  # TODO: limit this association to student users only                     
  belongs_to :teacher, class_name: 'User',
                       optional: true

  # TODO: limit this association to student users only 
  has_many :lesson_plans, class_name: 'LessonPlan',
                          foreign_key: 'student_id',
                          dependent: :destroy

  ROLES.each do |role|
    define_method("#{role}?") { roles == role }

    define_singleton_method("create_#{role}!") do |student_params|
      student_params['roles'] = role
      User.create!(student_params)
    end
  end
end


