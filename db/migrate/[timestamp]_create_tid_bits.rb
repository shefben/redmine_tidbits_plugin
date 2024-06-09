class CreateTidBits < ActiveRecord::Migration[6.1]
  def change
    create_table :tid_bits do |t|
      t.integer :project_id
      t.string :subject
      t.text :body
      t.integer :user_id
      t.timestamps
    end

    add_index :tid_bits, :project_id
    add_index :tid_bits, :user_id
  end
end