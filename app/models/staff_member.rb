require 'bcrypt'
class StaffMember < ActiveRecord::Base
  include StringNormalizer

  has_many :events, class_name: 'StaffEvent', dependent: :destroy

  before_validation do
    self.email = normalize_as_email(email)
    self.email_for_index = email.downcase if email
    self.family_name = normalize_as_name(family_name)
    self.given_name = normalize_as_name(given_name)
    self.family_name_kana = normalize_as_furigana(family_name_kana)
    self.given_name_kana = normalize_as_furigana(given_name_kana)
  end

  KATAKANA_REGEXP = /\A[\p{katakana}\u{30fc}]+\z/

  validates :email, presence: true, email: { allow_blank: true }
  validates :family_name, :given_name, presence: true
  validates :family_name_kana, :given_name_kana, presence: true,
    format: { with: KATAKANA_REGEXP, allow_blank: true }
  validates :start_date, presence: true, date: {
    after_or_equal_to: Date.new(2000, 1, 1),
    before: -> (obj) { 1.year.from_now.to_date },
    allow_blank: true
  }
  validates :end_date, date: {
    after: :start_date,
    before: -> (obj) { 1.year.from_now.to_date },
    allow_blank: true
  }

  validates :email_for_index, uniqueness: { allow_blank: true }
  after_validation do
    if errors.include?(:email_for_index)
      errors.add(:email, :taken)
      errors.delete(:email_for_index)
    end
  end

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
