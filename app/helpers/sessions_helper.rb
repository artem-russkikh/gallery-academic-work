module SessionsHelper
  def current_user
    @sessions_current_user ||= User.find_by(id: session[:user_id])
  end

  def current_user?
    !!current_user
  end

  def guest?
    !current_user
  end
end
