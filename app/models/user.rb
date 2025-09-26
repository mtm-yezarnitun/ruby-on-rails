class User < ApplicationRecord
  enum role: { user: 0, admin: 1 }
  
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

    if user.new_record?
      generated_password = Devise.friendly_token[0, 20]
      user.password = generated_password
      user.user_name = auth.info.name
      user.save!

      user.send_welcome_email(generated_password)
    else
      user.save!
    end
    user
  end

  def send_welcome_email(raw_password = nil)
    Rails.logger.info "Sending welcome email to #{email}"
    UserMailer.welcome_email(self, raw_password).deliver_later
  end

end
