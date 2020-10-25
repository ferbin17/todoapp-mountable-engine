class CreateTodoappComments < ActiveRecord::Migration[6.0]
  def change
    create_table :todoapp_comments do |t|
      t.string :body
      t.references :todoapp_todo
      t.references :todoapp_user
      t.timestamps
    end
  end
end
