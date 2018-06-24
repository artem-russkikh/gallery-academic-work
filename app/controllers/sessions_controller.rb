class SessionsController < ApplicationController
  def signin_new
  end

  def signup_new
  end

  # search through ldap by email, password
  # ensure that user is created by ldap_id
  def signin
    return set_session_user_id!(nil, 'Введите email и пароль.') { render :signin_new } if params_valid?(:signin)
    ldap_result = LdapService.new.auth(params[:email], params[:password])
    return set_session_user_id!(nil, 'Нет такого пользователя.') { render :signin_new } if ldap_result.blank?
    user = User.find_by(ldap_id: ldap_result[:ldap_id])
    return set_session_user_id!(user.id, 'Вы вошли!') { redirect_to root_url } if user.present?
    user = User.new(ldap_result)
    return set_session_user_id!(user.id, 'Вы вошли!') { redirect_to root_url } if user.save
    set_session_user_id!(nil, 'Возникли проблемы. Попробуйте еще раз.') { render :signin_new }
  end

  # search through ldap by email, password
  # ensure that user is not found in LDAP directory and create it by ldap_id
  def signup
    return set_session_user_id!(nil, 'Введите данные.') { render :signup_new } if params_valid?(:signup)
    LdapService.mutex.synchronize do
      ldap_result = LdapService.new.add(
        email: params[:email],
        password: params[:password],
        name: params[:name],
        surname: params[:surname],
        role: 'painter'
      )
      return set_session_user_id!(nil, 'Невозможно зарегистрироваться.') { render :signup_new } if ldap_result.blank?
      user = User.find_by(ldap_id: ldap_result[:ldap_id])
      return set_session_user_id!(user.id, 'Вы вошли!') { redirect_to root_url } if user.present?
      user = User.new(ldap_result)
      return set_session_user_id!(user.id, 'Вы вошли!') { redirect_to root_url }  if user.save
      set_session_user_id!(nil, 'Возникли проблемы. Попробуйте еще раз.') { render :signup_new }
    end
  end

  def destroy
    set_session_user_id!(nil, 'Вы вышли!') { redirect_to root_url }
  end

  private

    def params_valid?(type_name)
      case type_name
      when :signin
        params[:email].blank? || params[:password].blank?
      when :signup
        params[:email].blank? || params[:password].blank? ||
          params[:name].blank? || params[:surname].blank?
      end
    end

    def set_session_user_id!(user_id, message)
      if user_id.present?
        session[:user_id] = user_id
        flash[:notice] = message
      else
        session[:user_id] = nil
        flash[:alert] = message
      end
      yield
    end
end
