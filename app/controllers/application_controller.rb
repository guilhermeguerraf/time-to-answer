class ApplicationController < ActionController::Base
  layout :layout_by_resource
  before_action :check_user_signed_in

  protected

  def check_user_signed_in
    params.extract!(:page) unless user_signed_in? || admin_signed_in?
  end

  def layout_by_resource
    devise_controller? ? "#{resource_class.to_s.downcase}_devise" : 'application'
  end
end
