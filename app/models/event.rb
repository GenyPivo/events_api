class Event < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :invites, dependent: :destroy

  validates_presence_of :purpose, :place, :event_time
  validates :purpose, length: { maximum: 300 }
  validate :event_time_cannot_be_in_the_past

  private

  def event_time_cannot_be_in_the_past
    if event_time.present? && event_time < Date.today
      errors.add(:event_time, "can't be in the past")
    end
  end

end
