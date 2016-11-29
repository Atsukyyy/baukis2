require 'bcrypt'
class StaffMember < ActiveRecord::Base
  include EmailHolder
  include PersonalNameHolder
  include PasswordHolder

  has_many :events, class_name: 'StaffEvent', dependent: :destroy

  validates :start_date, presence: true, date: {
    after_or_equal_to: Date.new(2000, 1, 1),
    before: ->(obj) { 1.year.from_now.to_date },
    allow_blank: true
  }
  validates :end_date, date: {
    after: :start_date,
    before: ->(obj) { 1.year.from_now.to_date },
    allow_blank: true
  }

  def active?
    !suspended? && start_date <= Date.today &&
      (end_date.nil? || end_date > Date.today)
  end

  #attr_accessor :password
end


  # attr_accessorは、データベースと連動せず、一時的にブラウザの１回のリクエストを処理する間のみ存在させるメソッド。

  #before_save do
  #  self.password_digest = BCrypt::Password.create(password)
  #end


  #has_secure_password


  #validates :password, length: {minimun:6}
