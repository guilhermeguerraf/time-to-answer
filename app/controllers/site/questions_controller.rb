class Site::QuestionsController < SiteController
  def index
    @questions = Question.includes(:answers, :subject).page(params[:page]).per(30)
  end
end
