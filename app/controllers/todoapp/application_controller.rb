module Todoapp
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :authenticate_user!
    helper_method :current_user
    
    protected
      def authenticate_user!
        redirect_to login_users_path unless session[:user_id].present?
      end
      
      def current_user
        Todoapp::User.find_by_id(session[:user_id])
      end

      def not_found
        raise ActionController::RoutingError.new('Not Found')
      end
  end
end
