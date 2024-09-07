class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  validates :title, presence: true
  validates :repeat_content, presence: true
  validates :repeat_times, presence: true
  validates :repeat_times, inclusion: { in: 1..10000000 }
end
