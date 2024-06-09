class TidBitTag < ActiveRecord::Base
  has_many :tid_bits

  validates :name, presence: true
  validates :color, presence: true
end