class Site::SearchController < SiteController
  def questions
    @questions = Question.search_by_term(params[:term]).page(params[:page])
  end

  def subject
    @questions = Question.search_by_subject(params[:subject_id]).page(params[:page])
  end
end
