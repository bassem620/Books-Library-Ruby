class AuthenticationTokenService
    HMAC_SECRET = 'my$ecretK3y'
    ALG_TYPE = 'HS256'

    def self.call(user_id)
        payload = {user_id: user_id}
        JWT.encode payload, HMAC_SECRET, ALG_TYPE
    end
end