module Authenticatable
  extend ActiveSupport::Concern

  # Constants
  TIME_FOR_REFRESH_TOKEN = 24.hours # Time for a refresh token before it expired

  included do
    # Class methods
    def self.from_token_payload(payload)
      find_by(id: payload['sub'])
    end

    # Instance methods
    def to_token_payload
      { sub: id, expired_at: Time.now + Knock.token_lifetime }
    end

    def set_new_token
      self.token = Knock::AuthToken.new(payload: to_token_payload).token
    end

    def need_refresh_token?(payload)
      time_to_refresh = Time.at(payload['exp']) - TIME_FOR_REFRESH_TOKEN
      Time.now >= time_to_refresh
    end
  end
end
