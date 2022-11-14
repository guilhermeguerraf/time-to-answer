class Site::WelcomeController < SiteController
  def index
    @questions = Question.includes(:answers).last(5).reverse
  end
end
