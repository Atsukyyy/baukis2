class Staff::SessionsController < Staff::Base
  def new
    if current_staff_member
      redirect_to :staff_root
    else
      @form = Staff::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Staff::LoginForm.new(params[:staff_login_form])
    if @form.email.present?
      staff_member = StaffMember.find_by(email_for_index: @form.email.downcase)
    end
    if Staff::Authenticator.new(staff_member).authenticate(@form.password)
<<<<<<< HEAD
      if staff_member.suspended?
        flash.now.alert = 'アカウント停止中です。'
        render action: 'new'
      else
        session[:staff_member_id] = staff_member.id
        flash.notice = 'ログインしました！！'
        redirect_to :staff_root
      end
=======
      session[:staff_member_id] = staff_member.id
      flash.notice = 'ログインしました！！'
      redirect_to :staff_root
>>>>>>> user_auth2
    else
      flash.now.alert = 'メアドまたはパスワードが正しくないです。。。'
      render action: 'new'
    end
  end

  def destroy
    session.delete(staff_member_id)
    flash.notice = 'ログアウトしました！！'
    redirect_to :staff_root
  end
end