class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :title, presence: true
  validates :body, { presence: true, length:{maximum: 255} }

  #ランキング機能の為
  is_impressionable

  def have_bestanswer?
    @answe_is_best = self.answers.map{ |answer|answer.is_best }
    @answe_is_best.include?(true)
  end

  def find_bestanswer
    self.answers.find_by(is_best: true)
  end

  def check_bestanswer
    bestanswers = Answer.where(is_best: 1)
    bestanswer_question_id = bestanswers.map{|bestanswer| bestanswer.question_id }
    btquestions = Question.where(id: bestanswer_question_id)
    btquestion_id = btquestions.map{|btquestion| btquestion.id }
    btquestion_id.include?(self.id) 
  end
end
