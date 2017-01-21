class Invite < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :invited_user_id, uniqueness: { scope: :event_id, message: '' }
end
