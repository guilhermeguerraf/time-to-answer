class Site::WelcomeController < SiteController
  def index
    @questions = Question.latest
  end
end
