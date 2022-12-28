class UsersBackoffice::FavoriteQuestionsController < UsersBackofficeController
  def index
    @favorites = Favorite.where(user_id: current_user.id)
  end

  def favorite
    @question_id = params[:question_id]
    @user_id = current_user.id

    Favorite.find_or_create_by(user_id: @user_id, question_id: @question_id)
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
