class Site::QuestionsController < SiteController
  def index
    @questions = Question.by_filter(params[:field] ||= 'created_at', params[:order] ||= 'DESC', params[:page])
  end
end
