class ApplicationController < ActionController::Base
  #Basic認証のアクション
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  # ベーシック認証
    def basic_auth
      authenticate_or_request_with_http_basic do |username, password|
        username == 'idom' && password == '2023'
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :kanji_last_name, :kanji_first_name, :kana_last_name, :kana_first_name, :birthday_yyyy_mm_dd])
  end
end
