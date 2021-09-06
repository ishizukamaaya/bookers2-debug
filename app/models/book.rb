class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
 has_many :favorited_users, through: :favorites, source: :user
	has_many :post_comments, dependent: :destroy
 validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

 is_impressionable

 default_scope -> { order(evaluation: :desc) }
 default_scope -> { order(created_at: :desc) }

 scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
 scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
 scope :created_thisweek, -> { where(created_at: Time.current.all_week) }
 scope :created_lastweek, -> { where(created_at: 1.week.ago.all_week) }

  def favorited_by?(user)
   favorites.where(user_id: user.id).exists?
  end
end
