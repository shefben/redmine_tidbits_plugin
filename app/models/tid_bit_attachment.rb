class TidBitAttachment < ActiveRecord::Base
  belongs_to :tid_bit

  validates :file_name, presence: true
  validates :file_path, presence: true
end