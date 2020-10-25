module Todoapp
  class Share < ApplicationRecord
    belongs_to :user, :foreign_key => "todoapp_user_id", :class_name => "Todoapp::User"
    belongs_to :todo, :foreign_key => "todoapp_todo_id", :class_name => "Todoapp::Todo"

    scope :shared_users, ->(id) { where('todoapp_todo_id=? AND is_owner=false', id).order(:todoapp_user_id) }
    scope :select_user_id, -> { select('todoapp_user_id') }
    scope :create_share_entry, ->(user_id, todo_id, position) { create(todoapp_user_id: user_id, todoapp_todo_id: todo_id, position: position) }
    scope :logged_user, ->(current_user) { where(todoapp_user_id: current_user.id) }

    # function to manage share entries
    def self.manage_share(params)
      shared = Todoapp::Share.select_user_id.shared_users(params[:id])
      create_entry_to_share(shared, params)
      remove_entry_from_share(shared, params)
    end

    # function to make new share entry
    def self.create_entry_to_share(shared, params)
      users = params[:users]
      users.each do |user_id|
        break if user_id == '0'

        next unless shared.find_by(todoapp_user_id: user_id).nil?

        user = Todoapp::User.find_by(id: user_id)
        unless user.nil?
          position = find_last_position(user)
          Todoapp::Share.create_share_entry(user_id, params[:id], position)
        else
          #show errors
          { errors: "Todo not found" }
        end
      end
    end

    # function to create a entry in share table on successfull todo entry creation
    def self.create_entry_in_share(todo, current_user)
      share = Todoapp::Share.new(todoapp_user_id: current_user.id, todoapp_todo_id: todo.id, is_owner: true)
      if share.save
        position = find_last_position(current_user)
        share.update(position: position)
      else
        #show errors
        { errors: todo.errors.full_messages }
      end
    end

    # function to remove share entry
    def self.remove_entry_from_share(shared, params)
      users = params[:users]
      shared.each do |share|
        unless users.include? share.user_id.to_s
          Todoapp::Share.find_by(todoapp_user_id: share.user_id, todoapp_todo_id: params[:id]).destroy
        end
      end
    end

    # function to find last todos position of a user
    def self.find_last_position(user)
      top_todo = user.shares.order(:position).last
      if top_todo.nil?
        1
      else
        top_todo.position + 1
      end
    end

  end
end
