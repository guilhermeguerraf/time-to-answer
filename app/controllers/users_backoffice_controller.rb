class UsersBackofficeController < ApplicationController
  before_action :authenticate_user!
  layout 'users'
end
