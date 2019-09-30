class Question < ApplicationRecord
  has_many :choice, dependent: :destroy
  has_many :answer, dependent: :destroy

  attribute :view_to_list, :integer, default: 0

  validates :question, presence: true
  validates :answer_type, presence: true
end
