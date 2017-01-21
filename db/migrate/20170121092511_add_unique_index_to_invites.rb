class AddUniqueIndexToInvites < ActiveRecord::Migration
  def change
    add_index :invites, [:invited_user_id, :event_id], unique: true
  end
end
