class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user
  mount_uploader :image, ImageUploader
  validates :body_or_image, presence: true

  private
    def body_or_image
      body.presence or image.presence
    end
end
