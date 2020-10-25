require_dependency "todoapp/application_controller"

module Todoapp
  class CommentsController < ApplicationController
    before_action :authenticate_user!

    helper FormattedTimeHelper

    # checks the privilage of user and creates comment
    def create
      @comment = Todoapp::Comment.create_comment(params, current_user)
    end

  end
end
