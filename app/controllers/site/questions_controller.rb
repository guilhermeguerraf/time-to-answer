class Site::QuestionsController < SiteController
  def index
    @questions = Question.all.page(params[:page]).per(30)
  end
end
