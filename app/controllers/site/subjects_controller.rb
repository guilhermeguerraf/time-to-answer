class Site::SubjectsController < SiteController
  def index
    @subjects = Subject.all.page(params[:page]).per(30)
  end

  def show
    @subject = Subject.find(params[:id])
    @questions = @subject.questions.page(params[:page]).per(10)
  end
  
end
