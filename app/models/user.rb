class User < ApplicationRecord
  after_create :send_welcome_email
  enum role: { user: 0, admin: 1 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts ,dependent: :destroy
  has_many :comments ,dependent: :destroy

  has_many :notifications, foreign_key: :recipient_id, dependent: :destroy
  has_many :sent_notifications, class_name: 'Notification', foreign_key: :actor_id, dependent: :destroy

  has_one_attached :profile_picture

  private

  def send_welcome_email
    Rails.logger.info "Sending welcome email to #{email}"
    UserMailer.welcome_email(self).deliver_later
  end
end
