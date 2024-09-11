# lib/tasks/export_csv.rake
require 'csv'

namespace :db do
  desc "Export data to CSV"
  task export_csv: :environment do
    # 出力するデータのモデルを指定
    data = ContentList.all

    # CSV ファイルのパスを指定
    CSV.open('db/exports/your_data.csv', 'w') do |csv|
      # ヘッダー行を書き込む
      csv << data.first.attributes.keys

      # 各データ行を書き込む
      data.find_each do |record|
        csv << record.attributes.values
      end
    end

    puts "Data exported to db/exports/your_data.csv"
  end
end
