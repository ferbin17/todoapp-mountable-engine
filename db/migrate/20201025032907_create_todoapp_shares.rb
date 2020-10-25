class CreateTodoappShares < ActiveRecord::Migration[6.0]
  def change
    create_table :todoapp_shares do |t|
      t.references :todoapp_todo
      t.references :todoapp_user
      t.bigint :position, default: false, null: false
      t.boolean :is_owner, default: false, null: false
      t.timestamps
    end
  end
end
