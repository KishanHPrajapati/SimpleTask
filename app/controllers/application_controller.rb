class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    # def user_url(param)

    #   '/'
    # end 
   
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
      # devise_parameter_sanitizer.for(:account_update).push(:fullname, :mobile_number, :address1, :address2, :city, :state, :country, :pincode, :pancard, :adhar_number, :linkedin_url)
    end
    
end
