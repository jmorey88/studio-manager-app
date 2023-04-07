class LessonPlan < ApplicationRecord


  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 500 } 
  validates :student_id, presence: true  


  belongs_to :student, class_name: 'User',
                       optional: true
end
