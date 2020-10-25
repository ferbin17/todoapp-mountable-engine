module Todoapp
  class User < ApplicationRecord
    attr_accessor :full_name, :password, :confirm_password, :dont_validate_password
    has_one :user_detail, dependent: :destroy, :class_name => "Todoapp::UserDetail"
    has_many :shares, :foreign_key => "todoapp_user_id", :class_name => "Todoapp::Share"
    has_many :todos, through: :shares, dependent: :destroy, :foreign_key => "todoapp_todo_id", :class_name => "Todoapp::Todo"
    has_many :comments, dependent: :destroy, :foreign_key => "todoapp_user_id", :class_name => "Todoapp::Comment"
    
    validates_presence_of :email_id#,:full_name, :phone_no
    validates_presence_of :password, if: Proc.new{|user| user.dont_validate_password != false}
    validates_presence_of :confirm_password, if: Proc.new{|user| user.new_record?}
    validate :password_match, if: Proc.new{|user| user.password.present?}
    validates :email_id, uniqueness: { scope: :is_active,
        message: "can have only one active per time." }, if: Proc.new{|user| user.new_record?} #:phone_no
    # validates :phone_no, numericality: true, length: { minimum: 10, maximum: 10 }
    
    before_save :hash_password, if: Proc.new{|user| user.dont_validate_password != false}
    after_create :create_user_detail

    scope :all_user_except_one, ->(user) { where('id != ?', user.id) }
    scope :shared_users, ->(id) { where('todoapp_todo_id=? AND is_owner=false', id).order(:todoapp_user_id) }
    scope :user_join_shares, ->(id) { joins(:shares).select('todoapp_users.*, todoapp_shares.*').shared_users(id) }
    scope :get_shared_users, ->(todo) { joins(:shares).select('todoapp_users.*, todoapp_shares.*').where('todoapp_shares.todoapp_todo_id = ? and todoapp_shares.todoapp_user_id != ?', todo.id, todo.todoapp_user_id) }
    scope :get_comments, ->(todo) { joins(:comments).select('todoapp_users.*, todoapp_comments.*').where('todoapp_comments.todoapp_todo_id = ?', todo.id) }
    scope :active, -> { where(is_active: true) }

    #f etch acitve todos of a todos
    def active_todos(params)
      todos.todo_join_shares(true, params)
    end

    # returns either all active todos or all inactive_only todos
    def active_or_inactive_todos(params)
      flag = params[:active_status] == 'active_only'
      todos.todo_join_shares(flag, params)
    end

    # function to get a todo along with its user details
    def get_a_todo(params)
      todos.select_shares_and_todo.where(id: params[:id])[0]
    end

    # Searching todo, returns all active todos if keyword is not present else returns the search results
    def search_todo(search_key, params)
      if search_key.present?
        todos.search("%#{search_key}%", params)
      else
        todos.todo_join_shares(true, params)
      end
    end

    def previous_todo(current_todo)
      todos.select_shares_and_todo.where('position < ?', current_todo.position).active_status_todos(current_todo.active?).order_by(:desc).limit(1)
    end

    def next_todo(current_todo)
      todos.select_shares_and_todo.where('position > ?', current_todo.position).active_status_todos(current_todo.active?).order_by(:asc).limit(1)
    end
      
    def authenticate
      user = Todoapp::User.active.where("email_id = ?", self.email_id).first
      if user.present?
        return user.hashed_password == Digest::SHA1.hexdigest(user.password_salt.to_s + self.password)
      end
      return false
    end
    
    def send_otp_by_mail(otp)
      Todoapp::UserMailer.with(user: self, otp: otp).send_otp.deliver_now
    end
      
    def send_password_reset_token_by_mail
      self.update(reset_password_token: SecureRandom.base64(17), dont_validate_password: false)
      Todoapp::UserMailer.with(user: self).send_password_reset_token.deliver_now
    end
      
    def self.minimum_password_length
      false
    end
      
    private
      def password_match
        if password != confirm_password
          errors.add(:password, "doesn't match")
        end
      end
        
      def hash_password
        self.password_salt =  SecureRandom.base64(8) if self.password_salt == nil
        self.hashed_password = Digest::SHA1.hexdigest(self.password_salt + self.password)
      end
      
      def create_user_detail
        build_user_detail(full_name: full_name, email_id: email_id, phone_no: phone_no)
        save
      end
  end
end
