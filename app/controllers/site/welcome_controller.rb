class Site::WelcomeController < SiteController
  def index
    @questions = Question.latest
    @subjects = Subject.more_popular
  end
end
