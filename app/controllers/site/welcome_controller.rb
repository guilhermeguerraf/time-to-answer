class Site::WelcomeController < SiteController
  def index
    @questions = Question.includes(:answers, :subject).order(created_at: :desc).page(params[:page]).per(5)
    @subjects = Subject.order(questions_count: :desc).limit(6)
  end
end
