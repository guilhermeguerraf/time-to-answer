class UsersBackoffice::ZipCodeController < UsersBackofficeController
  def show
    @zip_code = CEP.new(params[:zip_code])
  end
end
