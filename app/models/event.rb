class Event < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :invites, dependent: :destroy

  validates_presence_of :purpose, :place, :event_time
  validates :purpose, length: { maximum: 300 }
  
end
