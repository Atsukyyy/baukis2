require 'bcrypt'
class Staff::Authenticator < Staff::Base
  def initialize(staff_member)
    @staff_member = staff_member
  end
  def authenticate(raw_password)
    @staff_member &&
      #@staff_member.hashed_password &&
      @staff_member.password_digest &&
      @staff_member.start_date <= Date.today &&
      #(@staff_member.end_date.nil? || @staff_member.end_date > Date.today) &&
      #BCrypt::Password.new(@staff_member.hashed_password == raw_password)
      BCrypt::Password.new(@staff_member.password_digest) == raw_password
  end
end
