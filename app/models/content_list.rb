class ContentList < ApplicationRecord
  validates :title, presence: true
  validates :repeat_content, presence: true
  validates :repeat_times, presence: true
  validates :repeat_times, inclusion: { in: 1..10000000 }
  belongs_to :user
end
