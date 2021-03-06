class Answer < ApplicationRecord
  belongs_to :question, counter_cache: true
  belongs_to :user
  has_many :reactions, dependent: :destroy

  validates :body, { presence: true, length:{maximum: 255} }

end
