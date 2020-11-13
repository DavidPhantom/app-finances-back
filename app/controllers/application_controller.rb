class ApplicationController < ActionController::API
  include ErrorHandleable
  include Knock::Authenticable

  after_action :refresh_bearer_auth_header, if: :bearer_auth_header_present

  private

  def bearer_auth_header_present
    request.env['HTTP_AUTHORIZATION'] =~ /Bearer/
  end

  def auth_token
    # Remove 'Bearer ' from the Authorization of header
    token = request.headers['Authorization'][7..-1]
    Knock::AuthToken.new(token: token)
  end

  def refresh_bearer_auth_header
    return unless current_user && current_user&.need_refresh_token?(auth_token.payload)

    # :nocov:
    headers['Access-Control-Expose-Headers'] = 'Authorization'
    headers['Authorization'] = current_user.set_new_token
    # :nocov:
  end
end
