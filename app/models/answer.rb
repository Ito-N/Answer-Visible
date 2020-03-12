class Answer < ApplicationRecord
  validates :user_id, presence:true
  validates :question_id, presence:true
  validates :sentence, presence:true
  validates :questionnaire_number, presence:true

  belongs_to :question
  belongs_to :user
end
