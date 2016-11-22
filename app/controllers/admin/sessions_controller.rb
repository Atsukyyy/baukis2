class Admin::SessionsController < Admin::Base
  skip_before_action :authorize

  def new
    if current_administrator
      redirect_to :admin_root
    else
      @form = Admin::LoginForm.new
      render action: 'new'
    end
  end
  def create
    @form = Admin::LoginForm.new(params[:admin_login_form])
    if @form.email.present?
      administrator = Administrator.find_by(email_for_index: @form.email.downcase)
    end
    if Admin::Authenticator.new(administrator).authenticate(@form.password)
      if administrator.suspended?
        flash.now.alert = 'アカウント停止中'
        render action: 'new'
      else
        session[:administrator_id] = administrator.id
        flash.notice = 'ログインしました！！'
        session[:last_access_time] = Time.current
        redirect_to :admin_root
      end
    else
      flash.now.alert = 'メアドまたはパスワードが正しくないです。。'
      render action: 'new'
    end
  end
  def destroy
    session.delete(:administrator_id)
    flash.notice = 'ログアウトしました！！'
    redirect_to :admin_root
  end
end
