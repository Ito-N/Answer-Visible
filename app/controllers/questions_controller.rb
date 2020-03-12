class QuestionsController < ApplicationController
  def new
    @question = Question.new
    @question.build_questionnaire
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      redirect_to new_question_path, success: "投稿に成功しました"
    else
      flash[:danger] = "投稿に失敗しました"
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
    #質問選択肢に対する回答を円チャートで表示。円チャートは３種類作成
    #①回答選択肢(1 or 2)に対する回答集計結果　②①をさらに性別ごとに表示　③①を年齢ごとに表示
    arr_all = []
    arr_gender_num1 = []
    arr_gender_num2 = []
    arr_age_num1 = []
    arr_age_num2 = []
    @answers.each { |ans|
      arr_all.push(ans.questionnaire_number)
      if ans.questionnaire_number == 1
        arr_gender_num1.push(ans.user.gender)
        arr_age_num1.push(Date.today.year - ans.user.age)
      else
        arr_gender_num2.push(ans.user.gender)
        arr_age_num2.push(Date.today.year - ans.user.age)
      end
    }
    #①回答選択肢(1 or 2)に対する回答集計結果
    sum_all_num1 = arr_all.select{|n| n == 1}.size
    sum_all_num2 = arr_all.select{|n| n == 2}.size
    @data = {@question.questionnaire.option1 => sum_all_num1, @question.questionnaire.option2 => sum_all_num2}
    #②①をさらに性別ごとに表示
    sum_man_num1 = arr_gender_num1.select{|n| n == 1}.size
    sum_woman_num1 = arr_gender_num1.select{|n| n == 2}.size
    sum_man_num2 = arr_gender_num2.select{|n| n == 1}.size
    sum_woman_num2 = arr_gender_num2.select{|n| n == 2}.size
    @data_gender_num1 = {'男性' => sum_man_num1, '女性' => sum_woman_num1}
    @data_gender_num2 = {'男性' => sum_man_num2, '女性' => sum_woman_num2}
    #③①をさらに年齢ごとに表示
    sum_10_num1 = 0
    sum_20_num1 = 0
    sum_30_num1 = 0
    sum_40_num1 = 0
    sum_50_num1 = 0
    sum_60_num1 = 0
    sum_el_num1 = 0
    sum_10_num2 = 0
    sum_20_num2 = 0
    sum_30_num2 = 0
    sum_40_num2 = 0
    sum_50_num2 = 0
    sum_60_num2 = 0
    sum_el_num2 = 0

    arr_age_num1.each { |n|
      if n >= 10 && n <=19
        sum_10_num1 += 1
      elsif n >= 20 && n <=29
        sum_20_num1 += 1
      elsif n >= 30 && n <=39
        sum_30_num1 += 1
      elsif n >= 40 && n <=49
        sum_40_num1 += 1
      elsif n >= 50 && n <=59
        sum_50_num1 += 1
      elsif n >= 60 && n <=69
        sum_60_num1 += 1
      else
        sum_el_num1 += 1
      end
      }
      arr_age_num2.each { |n|
        if n >= 10 && n <=19
          sum_10_num2 += 1
        elsif n >= 20 && n <=29
          sum_20_num2 += 1
        elsif n >= 30 && n <=39
          sum_30_num2 += 1
        elsif n >= 40 && n <=49
          sum_40_num2 += 1
        elsif n >= 50 && n <=59
          sum_50_num2 += 1
        elsif n >= 60 && n <=69
          sum_60_num2 += 1
        else
          sum_el_num2 += 1
        end
        }
    @data_age_num1 = {'10代' => sum_10_num1, '20代' => sum_20_num1, '30代' => sum_30_num1, '40代' => sum_40_num1, '50代' => sum_50_num1, '60代' => sum_60_num1, 'その他' => sum_el_num1}
    @data_age_num2 = {'10代' => sum_10_num2, '20代' => sum_20_num2, '30代' => sum_30_num2, '40代' => sum_40_num2, '50代' => sum_50_num2, '60代' => sum_60_num2, 'その他' => sum_el_num2}
  end

  def edit
    @question.update(question_params)
    redirect_to new_question_path, success: "投稿を更新しました"
  rescue
    render :new
  end

  def index
    @questions = Question.all
  end

  private
  def question_params
    params.require(:question).permit(:title, :content, :url, :category, questionnaire_attributes: [:id, :question_id, :option1, :option2])
  end
end
