class Comment < ActiveRecord::Base
  include Api::Attach::ContentTypes
  belongs_to :user
  belongs_to :event

  has_attached_file :document
  validates_attachment_content_type :document,
                                    content_type: PERMITTED_MIME,
                                    size: { in: 0..10.megabytes }

  validates :message, length: { maximum: 1000 }, presence: true

  def has_access?(user)
    event.has_access?(user)
  end
end
