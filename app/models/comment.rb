class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :message, length: { maximum: 200 }, presence: true
end
