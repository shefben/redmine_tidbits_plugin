class TidBit < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :tid_bit_tag, optional: true
  has_many :tid_bit_attachments, dependent: :destroy
  has_many :tidbit_comments, dependent: :destroy

  acts_as_taggable_on :tags

  validates :subject, presence: true
  validates :body, presence: true

  accepts_nested_attributes_for :tid_bit_attachments, allow_destroy: true

  def body_html
    bbcode_to_html(body).gsub("\n", "<br>").html_safe
  end

  private

  def bbcode_to_html(text)
    require 'bb-ruby'
    BBRuby.to_html(body).gsub("\n", "<br>").html_safe
  end
end