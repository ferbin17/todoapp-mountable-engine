module Todoapp
  class Comment < ApplicationRecord
    validates_presence_of :body
    belongs_to :user, :foreign_key => "todoapp_user_id", :class_name => "Todoapp::User"
    belongs_to :todo, :foreign_key => "todoapp_todo_id", :class_name => "Todoapp::Todo"

    scope :comment_join_user, ->(todo_id, comment_id) { joins(:user).select('todoapp_users.*, todoapp_comments.*').where('todoapp_comments.todoapp_todo_id = ? and todoapp_comments.id=?', todo_id, comment_id) }

    # function to create comments
    def self.create_comment(params, current_user)
      todo = Todoapp::Todo.find_by(id: params[:todo_id])
      unless todo.nil?
        shares = todo.shares.select('todoapp_user_id')
        unless shares.find_by(todoapp_user_id: current_user.id).nil?
          comment = todo.comments.build(generate_comment(params).merge(todoapp_user_id: current_user.id))
          if comment.save
            comment = Todoapp::Comment.comment_join_user(todo.id, comment.id)[0]
            if params.key?(:new_value)
              todo.update(completion_status: params[:new_value])
              if todo.save
              else
                #show errors
                { errors: todo.errors.full_messages }
              end
            end
          else
            #show errors
            { errors: todo.errors.full_messages }
          end
        end
        comment
      else
        #show errors
        { errors: "Todo not found" } 
      end
     end

     # function to construct comment body
     def self.generate_comment(params)
       if params.key?(:comment)
         body = { 'body' => "\"#{params[:comment]}\"" }
       else
         (params[:old_value]).gsub!((params[:old_value])[-1], '')
         unless params[:old_value] == params[:new_value]
           body = { body: 'Task has been updated from <span class="green-text">' +
              params[:old_value] + '%<span> to <span class="green-text">' +
               params[:new_value] + '%<span>' }
           body = { body: 'Status of the task changed to <span class="green-text">Done<span>' } if params[:new_value] == '100'
         end
       end
       body
     end
     
  end
end
