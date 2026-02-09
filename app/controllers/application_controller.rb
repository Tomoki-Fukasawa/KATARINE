class ApplicationController < ActionController::Base
  before_action :basic_auth, unless: -> { Rails.env.test? }
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Devise 登録後のリダイレクト先
  def after_sign_up_path_for(resource)
    root_path  # 例：ログイン後のトップページ
  end

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    root_path
  end


  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
     keys: [:password, :password_confirmation, :nickname,
     :last_name_kanji,:first_name_kanji,:last_name_kana,:first_name_kana,
     :birth_day, :image])
  end
end