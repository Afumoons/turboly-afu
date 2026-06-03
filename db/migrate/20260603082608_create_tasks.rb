class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :description, null: false
      t.date :due_date, null: false
      t.integer :priority, null: false, default: 2
      t.boolean :completed, null: false, default: false
      t.datetime :completed_at

      t.timestamps
    end

    add_index :tasks, %i[user_id due_date]
    add_index :tasks, %i[user_id priority]
    add_index :tasks, %i[user_id completed]
  end
end
