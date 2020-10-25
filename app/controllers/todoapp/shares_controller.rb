require_dependency "todoapp/application_controller"

module Todoapp
  class SharesController < ApplicationController
    before_action :authenticate_user!

    # shows all the users with check for shared users on share button click
    def index
      @users =  Todoapp::User.all_user_except_one(current_user)
      @shares = Todoapp::Share.select_user_id.shared_users(params[:id])
    end

    # add or remove new users as shared users for a particular todo
    def create
      Todoapp::Share.manage_share(params)
      @shares = Todoapp::User.user_join_shares(params[:id])
    end

  end
end
