class UsersBackoffice::FavoriteQuestionsController < UsersBackofficeController
  def index
    @favorites = Favorite.where(user: current_user)
  end

  def favorite
    if current_user.present?
      @question = Question.find(params[:question_id])
      Favorite.find_or_create_by(user: current_user, question: @question)
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])

    if @favorite.destroy
      redirect_to users_backoffice_favorite_questions_path, notice: 'Favorito excluído com sucesso!'
    else
      redirect_to users_backoffice_favorite_questions_path
    end
  end
  
end
