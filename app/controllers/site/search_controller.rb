class Site::SearchController < SiteController
  def questions
    @questions = Question.search(params[:term], page: params[:page], per_page: 10)
  end

  def subject
    @questions = Question.find_by_subject(params[:id]).page(params[:page])
  end
end
