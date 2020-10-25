class CreateTodoappTodos < ActiveRecord::Migration[6.0]
  def change
    create_table :todoapp_todos do |t|
      t.string :body
      t.datetime :datetime
      t.bigint :completion_status, default: 0, null: false
      t.boolean :active, default: true
      t.integer :position
      t.timestamps
    end
  end
end
