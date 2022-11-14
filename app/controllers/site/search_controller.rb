class Site::SearchController < SiteController
  def questions
    @questions = Question.search_by(params[:term], params[:page])
  end
end
