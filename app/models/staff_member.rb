require 'bcrypt'
class StaffMember < ActiveRecord::Base
  has_many :events, class_name: 'StaffEvent', dependent: :destroy

  before_validation do
    self.email_for_index = email.downcase if email
  end

  KATAKANA_REGEXP = /¥A[¥p{katakana}¥u{30fc}]+¥z/

  validates :family_name, :given_name, presence: true
  validates :family_name_kana, :given_name, presence: true,
    format: { with: KATAKANA_REGEXP, allow_blank: true }

  attr_accessor :password
  # attr_accessorは、データベースと連動せず、一時的にブラウザの１回のリクエストを処理する間のみ存在させるメソッド。

  #before_save do
  #  self.password_digest = BCrypt::Password.create(password)
  #end


  #has_secure_password


  #validates :password, length: {minimun:6}

  def password=(raw_password)
    if raw_password.kind_of?(String)
      #self.hashed_password = BCrypt::Password.create(raw_password)
      self.password_digest = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      #self.hashed_password = nil
      self.password_digest = nil
    end
  end

  def active?
    #binding.pry
    !suspended? && start_date <= Date.today && (end_date.nil? || end_date > Date.today)
  end
end
