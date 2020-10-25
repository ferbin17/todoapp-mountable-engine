module Todoapp
  class UserDetail < ApplicationRecord
    belongs_to :user, :class_name => "Todoapp::User"
    validates_presence_of :email_id#, :phone_no, :full_name
  end
end
