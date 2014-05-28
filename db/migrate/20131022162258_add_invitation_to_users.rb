class AddInvitationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :invitation_id, :integer
    add_column :users, :invitation_limit, :string
    add_column :users, :integer, :string
  end
end
