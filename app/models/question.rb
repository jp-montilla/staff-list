class Question < ApplicationRecord
  has_many :choice, dependent: :destroy
  has_many :answer, dependent: :destroy

  validates :question, presence: true
  validates :answer_type, presence: true
  validates :view_to_list, presence: true
end
