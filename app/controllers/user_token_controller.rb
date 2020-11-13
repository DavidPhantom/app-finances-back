class UserTokenController < Knock::AuthTokenController
  protect_from_forgery unless: -> { request.format.json? }
  include ErrorHandleable

  def create
    @token = auth_token
    @user = entity
    if @user
      render(
        status: :created,
        json: UserSerializer.new(@user, params: { token: @token.token }).serialized_json
      )
    else
      render_forbidden_response
    end
  end

  private

  def entity
    @entity ||= entity_class.find_by(email: auth_params[:email])
  end

  def auth_params
    params.permit(*whitelisted)
  end

  def whitelisted
    [
      :email,
      :password
    ]
  end
end
