class CreateLessonPlans < ActiveRecord::Migration[7.0]
  def change
    create_table :lesson_plans do |t|
      t.string :title
      t.text :body
      t.integer :student_id
      

      t.timestamps
    end
  end
end
