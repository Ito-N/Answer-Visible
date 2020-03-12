class AnswersController < ApplicationController
  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new
  end

  def create
    @answer = current_user.answers.new(answer_params)

    if @answer.save
      redirect_to questions_path, success: "投稿に成功しました"
    else
      flash[:danger] = "投稿に失敗しました"
      render :new
    end
  end



  private
  def answer_params
    params.require(:answer).permit(:question_id, :sentence, :questionnaire_number)
  end

end
