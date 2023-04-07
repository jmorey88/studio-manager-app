# frozen_string_literal: true

# This Model is for users that can be either teachers or students
class User < ApplicationRecord
  include ActiveModel::Dirty

  # define_attribute_methods :password

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
  validate :valid_password?, on: [:create, :update] 
  validate :ensure_valid_roles
  validate :valid_teacher_id?

  # def initialize
  #   @password = nil
  # end

  # def password
  #   @password
  # end

  # def password=(val)
  #   password_will_change! unless val == @password
  #   @password = val
  # end

  # def save
  #   changes_applied
  # end

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

  def valid_password?
    return unless password_digest_changed?
    if password.blank?
      errors.add(:password, 'can\'t be blank')
    elsif password.length < 6
      errors.add(:password, 'must be 6 or more characters')
    end
  end

  # return true if role is student for students or teacher for teachers

  # def student?
  #   roles == STUDENT_ROLE
  # end

  # def teacher?
  #   roles == TEACHER_ROLE
  # end

  # find all students
  scope :students, -> { where(roles: STUDENT_ROLE) }

  # find all teachers
  scope :teachers, -> { where(roles: TEACHER_ROLE) }

  # add user association

  has_many :students, class_name: 'User',
                      foreign_key: 'teacher_id'

  belongs_to :teacher, class_name: 'User',
                       optional: true

  #how to make this for students only
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


