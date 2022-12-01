class Site::SearchController < SiteController
  def questions
    @questions = Question.find_by_term(params[:term]).page(params[:page])
  end

  def subject
    @questions = Question.find_by_subject(params[:id]).page(params[:page])
  end
end
