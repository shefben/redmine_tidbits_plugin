class CreateTidBitAttachments < ActiveRecord::Migration[6.1]
  def change
    create_table :tid_bit_attachments do |t|
      t.integer :tid_bit_id
      t.string :file_name
      t.string :file_path
      t.timestamps
    end
  end
end