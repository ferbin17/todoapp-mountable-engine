module Todoapp
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    rescue_from ActiveRecord::RecordNotFound, with: :not_record_found 
    rescue_from Exception, with: :error
    rescue_from ActionController::RoutingError, with: :not_found
    helper_method :authenticate_user!
    helper_method :current_user
    
    def raise_not_found
      raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
    end
  
    def not_found
      flash[:warning] = "Page not found"
      respond_to do |format|
        format.html{ redirect_to :root}
        # format.html { render file: Rails.public_path.join('404.html'), status: :not_found, layout: false }
        format.xml { head :not_found }
        format.any { head :not_found }
      end
    end
    
    def not_record_found
      flash[:warning] = "No record found with ID"
      respond_to do |format|
        format.html { redirect_to :root }
        format.xml { head :not_found }
        format.any { head :not_found }
      end
    end
    
    def error
      flash[:warning] = "Encountered some error. Sorry for the inconvenience"
      respond_to do |format|
        format.html{ redirect_to :root}
        # format.html { render file: Rails.public_path.join('500.html'), status: :not_found, layout: false }
        format.xml { head :not_found }
        format.any { head :not_found }
      end
    end
    
    protected
      def authenticate_user!
        redirect_to login_users_path unless session[:user_id].present?
      end
      
      def current_user
        Todoapp::User.find_by_id(session[:user_id])
      end
  end
end
