class Question < ApplicationRecord
  validates :user_id, presence:true
  validates :title, presence:true
  validates :content, presence:true
  validates :category, presence:true

  belongs_to :user
  default_scope -> { order(created_at: :desc) }

  mount_uploader :url, UrlUploader

  has_one :questionnaire, dependent: :destroy
  accepts_nested_attributes_for :questionnaire

  has_many :favorites
  has_many :favorite_users, through: :favorites, source: "user"
  has_many :answers, dependent: :destroy
end
