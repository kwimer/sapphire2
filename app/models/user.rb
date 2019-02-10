class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  before_create :set_admin

  def admin?
    role == 'admin'
  end

  protected

  def set_admin
    self.role = 'admin' if email.split('@')[1] = 'igems.tv'
  end


end
