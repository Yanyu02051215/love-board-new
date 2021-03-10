class QuestionsController < ApplicationController
  before_action :authenticate_user!,only:[:edit,:new,:create,:update,:destroy]
  before_action :find_question, only: [:edit,:update,:destroy]
  before_action :correct_user, only: [:edit, :update,:destroy]
  impressionist :actions=> [:show]
  def index
    @search = Question.ransack(params[:q])
    @results = @search.result.page(params[:page]).order(created_at: :desc).per(10)
    respond_to do |format|
      format.html
      format.csv do
        send_data render_to_string, filename: "questions.csv", type: :csv
      end
    end
  end

  def show
    @reaction = Reaction.new
    @question = Question.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to :root
  end

  def edit
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    if @question.destroy
      redirect_to root_path,notice:'削除に成功しました'
    else
      redirect_to root_path,alert:'削除に失敗しました'
    end
  end

  def gender
    @users = User.where(gender: params[:gender]).includes(:questions)
    @questions = @users.map{|user| user.questions }
    @search = Question.ransack(params[:q])
    @gender = Gender.find(params[:gender]).value
  end

  def age
    @users = User.where(age: params[:age]).includes(:questions)
    @questions = @users.map{|user| user.questions }
    @search = Question.ransack(params[:q])
    @age = Age.find(params[:age]).value
  end

  def category
    @questions = Question.where(category: params[:category])
    @search = Question.ransack(params[:q])
    @category = Category.find(params[:category]).value
  end

  def userrank
    @user_ranks = User.find(Answer.group(:user_id).order('count(user_id) desc').limit(10).pluck(:user_id))
    @search = Question.ransack(params[:q])
  end

  def rank
    @all_ranks = Question.find(Bookmark.group(:question_id).order('count(question_id) desc').limit(10).pluck(:question_id))
    @search = Question.ransack(params[:q])
  end

  def pvrank
    @pv_ranks = Question.find(Impression.group(:impressionable_id).order('count(impressionable_id) desc').limit(10).pluck(:impressionable_id))
    @search = Question.ransack(params[:q])
  end


  private

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, :category)
  end

  def correct_user
    @question = Question.find(params[:id])
    unless @question.user_id == current_user.id
      redirect_to root_url
    end
  end

end
