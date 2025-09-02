class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  extend FriendlyId
  friendly_id :title, use: :slugged

  def self.ransackable_attributes(auth_object = nil)
    ['title']
  end
end
