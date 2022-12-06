class Site::AnswerController < SiteController
  def question
    answer = Rails.cache.read(params[:answer]).split("@@")

    @question_id = answer.first
    @correct = ActiveModel::Type::Boolean.new.cast(answer.last)

    if user_signed_in?
      UserStatistic.set_statistic_by_answer(current_user, @correct)
    end
  end
end
