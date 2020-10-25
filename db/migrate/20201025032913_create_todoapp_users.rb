class CreateTodoappUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :todoapp_users do |t|
      ## Database authenticatable
      t.string :username, index: true, foreign_key: true, unique: true
      t.string :email_id, index: true, foreign_key: true, unique: true
      t.string :password_salt
      t.string :hashed_password
      ## Recoverable
      t.string   :reset_password_token, index: true, foreign_key: true, unique: true
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0 # Only if lock strategy is :failed_attempts
      t.string   :unlock_token, index: true, foreign_key: true, unique: true
      t.datetime :locked_at

      ## Additional
      t.string :phone_no
      t.integer :user_detail_id
      t.boolean :is_admin, default: false
      t.boolean :is_seller, default: false
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
