class ReactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_reaction, only: [:update,:destroy]
  before_action :correct_user, only: [:edit, :update,:destroy]

  def create
    reaction = Reaction.new(reaction_params)
    reaction.user_id = current_user.id
    reaction.answer_id = params[:answer_id]

    if reaction.save
      redirect_to (question_url(reaction.question))
    else
      redirect_to question_path(reaction.question.id)
    end
  end

  def edit
    @reaction = Reaction.find(params[:id])
  end

  def update
    @reaction = Reaction.find(params[:id])
    answer_id = @reaction.answer_id
    answer = Answer.find(answer_id)
    question = Question.find(answer.question_id)
    if @reaction.update(reaction_params)
      redirect_to(question_url(question)) 
    else
      render :edit
    end
  end


  private

  def find_reaction
    @reaction = Reaction.find(params[:id])
  end

  def reaction_params
    params.require(:reaction).permit(:body)
  end

  def correct_user
    @reaction = Reaction.find(params[:id])
      unless @reaction.user_id == current_user.id
        redirect_to root_url
      end
  end
end
