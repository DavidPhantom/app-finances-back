class UserSerializer < BaseSerializer
  attributes :username,
             :email,
             :created_at,
             :updated_at

  attribute :token do |_, params|
    params[:token]
  end
end
