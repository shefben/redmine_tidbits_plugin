class TidbitComment < ActiveRecord::Base
  belongs_to :tid_bit
  belongs_to :user

  validates :content, presence: true
end