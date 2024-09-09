class AddUserIdToContentLists < ActiveRecord::Migration[7.2]
  def change
    add_reference :content_lists, :user, foreign_key: true, null: true
  end
end
