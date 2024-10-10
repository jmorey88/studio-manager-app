class AddIndexesToLessonPlansAndUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :lesson_plans, %i[student_id created_at]
    add_index :users, %i[email roles]
    add_index :users, :teacher_id, where: "roles = 'student'"
  end
end
