class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.integer :user_id
      t.integer :status
      t.timestamps
    end
  end
end
