class AddIndexToConversation < ActiveRecord::Migration[5.0]
  def change
  end

  add_index :conversations, [:recipient_id, :sender_id], unique: true
end
