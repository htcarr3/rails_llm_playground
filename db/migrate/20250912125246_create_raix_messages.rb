class CreateRaixMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :raix_messages do |t|
      t.references :raix_chat, null: false, foreign_key: true
      t.string :model_id
      t.string :role
      t.text :content
      t.timestamps
    end
  end
end
