# frozen_string_literal: true

class AddUserRollColumns < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :roles, :string
    add_column :users, :teacher_id, :integer
  end
end
