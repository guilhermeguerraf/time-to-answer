class Site::AnswerController < SiteController
  def question
    @answer = Answer.find(params[:answer])

    if user_signed_in?
      UserStatistic.set_statistics(@answer, current_user)
    end
  end
end
