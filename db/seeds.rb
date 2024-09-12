require 'csv'

# CSVファイルからデータを読み込む
user_csv_file = 'db/seeds/csv/user.csv'
content_csv_file = 'db/seeds/csv/content.csv'
content_csv_file2 = 'db/seeds/csv/your_data.csv'

# ユーザーデータのシード
CSV.foreach(user_csv_file, headers: true) do |row|
  User.find_or_create_by(id: row['id']) do |user|
    user.name = row['name']
    user.email = row['email']
    user.password = row['password']
    user.created_at = row['created_at']
    user.updated_at = row['updated_at']
  end
end

# ContentListデータのシード
CSV.foreach(content_csv_file2, headers: true) do |row|
  ContentList.find_or_create_by(id: row['id']) do |content|
    content.title = row['title']
    content.repeat_content = row['repeat_content']
    content.repeat_times = row['repeat_times']
    content.created_at = row['created_at']
    content.updated_at = row['updated_at']
    content.user_id = row['user_id']
  end
end
