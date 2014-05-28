class CreateFutures < ActiveRecord::Migration
  def change
    create_table :futures do |t|
      t.string :name
      t.string :alias
      t.float :valuenew
      t.float :valueold

      t.timestamps
    end
  end
end
