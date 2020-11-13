module Request
  module AuthHelpers
    def auth_headers(user)
      token = user.set_new_token
      {
        'Authorization': "Bearer #{token}",
        'Content-Type': 'application/json'
      }
    end

    def bearer_token(admin)
      token = admin.set_new_token
      "Bearer #{token}"
    end

    def auth_request!(request, admin)
      request.headers['accept'] = 'application/json'
      request.headers.merge! bearer_token(admin)
    end
  end
end
