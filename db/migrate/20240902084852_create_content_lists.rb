class CreateContentLists < ActiveRecord::Migration[7.2]
  def change
    create_table :content_lists do |t|
      t.string :title
      t.string :repeat_content
      t.integer :repeat_times

      t.timestamps
    end
  end
end
