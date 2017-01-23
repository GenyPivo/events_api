class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_attached_file :document
  validates :message, length: { maximum: 200 }, presence: true
end
