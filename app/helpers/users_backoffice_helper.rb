module UsersBackofficeHelper
  def avatar_url
    current_avatar = current_user.user_profile.avatar
    current_avatar.attached? ? current_avatar : 'img.png'
  end
end
