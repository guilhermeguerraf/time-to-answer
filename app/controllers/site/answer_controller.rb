class Site::AnswerController < SiteController
  def question
    @answer = Answer.find(params[:answer])

    if user_signed_in?
      UserStatistic.set_statistic_by_answer(@answer, current_user)
    end
  end
end
