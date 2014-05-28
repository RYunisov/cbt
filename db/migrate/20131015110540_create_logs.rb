class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.integer :method_id
      t.string :text
      t.integer :status

      t.timestamps
    end
  end
end
