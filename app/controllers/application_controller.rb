class ApplicationController < ActionController::Base
  layout :layout_by_resource
  before_action :set_action_params
  before_action :check_user_signed_in

  protected
    def set_action_params
      $action_params = params[:action]
    end

    def check_user_signed_in
      unless user_signed_in? || admin_signed_in?
        params.extract!(:page)
      end
    end
    
    def layout_by_resource
      devise_controller? ? "#{resource_class.to_s.downcase}_devise" : 'application'
    end
end
