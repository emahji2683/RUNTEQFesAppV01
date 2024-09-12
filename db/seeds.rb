# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'csv'

# テストデータとしてのCSVファイル名
filename = "test.csv"

CSV.foreach("db/seeds/csv/#{filename}", headers: true) do |row|
  # user_idを全て1に設定し、他のカラムはCSVから読み込み
  ContentList.find_or_create_by(id: row['id']) do |content|
    content.title = row['title']
    content.repeat_content = row['repeat_content']
    content.repeat_times = row['repeat_times']
    content.user_id = 1  # user_idを1に固定
    content.created_at = row['created_at']
    content.updated_at = row['updated_at']
  end
end

