class Comment < ApplicationRecord
  belongs_to :summary
  belongs_to :user
  has_many :comment_favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :content, presence: true

  def self.calc_level(current_user)
    current_user.summaries.count * 0.8 + current_user.memos.count * 0.3 + current_user.reviews.count * 0.1 + current_user.comments.count * 0.1
  end
end
