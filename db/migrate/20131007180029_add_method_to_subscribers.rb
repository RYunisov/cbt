class AddMethodToSubscribers < ActiveRecord::Migration
  def change
    add_column :subscribers, :method, :integer
  end
end
