class Site::SubjectsController < SiteController
  def index
    @subjects = Subject.all.page(params[:page]).per(30)
  end

  def show
    @subject = Subject.find(params[:id])
    @questions = Subject.find_all_questions_paged_by_subject_id(params[:id], params[:page])
  end
end
