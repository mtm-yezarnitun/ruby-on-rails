class User < ApplicationRecord
  after_create :send_welcome_email
  enum role: { user: 0, admin: 1 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :posts ,dependent: :destroy
  has_many :comments ,dependent: :destroy

  has_many :notifications, foreign_key: :recipient_id, dependent: :destroy
  has_many :sent_notifications, class_name: 'Notification', foreign_key: :actor_id, dependent: :destroy

  has_one_attached :profile_picture

  def self.from_omniauth(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first_or_initialize
    user.email = auth.info.email if user.email.blank?
    user.password ||= Devise.friendly_token[0, 20]
    user.user_name ||= auth.info.name
    user.save!
    user
  end

  private

  def send_welcome_email
    Rails.logger.info "Sending welcome email to #{email}"
    UserMailer.welcome_email(self).deliver_later
  end
end
