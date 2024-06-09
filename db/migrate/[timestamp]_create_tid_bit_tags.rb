class CreateTidBitTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tid_bit_tags do |t|
      t.string :name
      t.string :color

      t.timestamps
    end

    add_reference :tid_bits, :tid_bit_tag, foreign_key: true
  end
end