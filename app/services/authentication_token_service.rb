class AuthenticationTokenService
    HMAC_SECRET = 'my$ecretK3y'
    ALG_TYPE = 'HS256'

    def self.encode(user_id)
        payload = {user_id: user_id}
        JWT.encode payload, HMAC_SECRET, ALG_TYPE
    end

    def self.decode(token)
        decoded_token = JWT.decode token, HMAC_SECRET, true, {algorithm: ALG_TYPE}
        decoded_token[0]['user_id']
    end
end