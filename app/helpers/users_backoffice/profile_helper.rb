module UsersBackoffice::ProfileHelper
  def gender_selector(user, current_gender)
    user.user_profile.gender == current_gender ? 'btn-primary' : 'btn-default'
  end

  def avatar_url
    current_avatar = current_user.user_profile.avatar
    current_avatar.attached? ? current_avatar : 'img'
  end
  
end
