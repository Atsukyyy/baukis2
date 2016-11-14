class Staff::SessionsController < Staff::Base
  def new
    if current_staff_member
      redirect_to :staff_root
    else
      @form = Staff::LoginForm.new
      render action: 'new'
    end
  end

  #def create
  #  @form = Staff::LoginForm.new(params[:staff_login_form])
  #  if @form.email.present?
  #    staff_member = StaffMember.find_by(email_for_index: @form.email.downcase)
  #  end

  #  if @form && @form.authenticate(raw_password)
  #    flash.notice = 'ログインしました！！'
  #    redirect_to :staff_root
	#	else
  #    flash.now.alert = 'パスワードもしくはメアドが正しくないです。。'
  #    render action: 'new'
	#	end
	#end


  def create
    @form = Staff::LoginForm.new(params[:staff_login_form])
    if @form.email.present?
      staff_member = StaffMember.find_by(email_for_index: @form.email.downcase)
    end
    if Staff::Authenticator.new(staff_member).authenticate(@form.password)
      if staff_member.suspended?
        staff_member.events.create!(type: 'rejected')
        flash.now.alert = 'アカウント停止中です。'
        render action: 'new'
      else
        #session[:staff_member_id] = staff_member_id
        staff_member.events.create!(type: 'logged_in')
        flash.notice = 'ログインしました！！'
        redirect_to :staff_root
      end
    else
      flash.now.alert = 'メアドまたはパスワードが正しくないです。。。'
      render action: 'new'
    end
  end

  def destroy
    if current_staff_member
      current_staff_member.events.create!(type: 'logged_out')
    end
    session.delete(staff_member_id)
    flash.notice = 'ログアウトしました！！'
    redirect_to :staff_root
  end
end
