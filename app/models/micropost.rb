class Micropost < ApplicationRecord
  belongs_to :user, counter_cache: true

  default_scope -> { order(created_at: :desc) }

  validates :content, presence: true, length: {maximum: 140}
end
