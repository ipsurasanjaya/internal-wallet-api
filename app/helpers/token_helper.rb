require 'openssl'
require 'base64'

module TokenHelper
    SECRET_KEY = "your_secret_key"
    
    def self.encode(payload, exp = 24.hours.from_now)
        payload[:exp] = exp.to_i
        header = Base64.urlsafe_encode64({ alg: 'HS256', typ: 'JWT' }.to_json)
        payload = Base64.urlsafe_encode64(payload.to_json)
    
        signature = sign("#{header}.#{payload}")
    
        "#{header}.#{payload}.#{signature}"
    end
  
    def self.decode(token)
      header, payload, signature = token.split('.')
      return nil unless signature_valid?(header, payload, signature)
  
      decoded_payload = JSON.parse(Base64.urlsafe_decode64(payload), symbolize_names: true)
      return nil if decoded_payload[:exp] < Time.now.to_i
  
      decoded_payload
    rescue
      nil
    end
  
    private
  
    def self.sign(data)
      OpenSSL::HMAC.hexdigest('SHA256', SECRET_KEY, data)
    end
  
    def self.signature_valid?(header, payload, signature)
      expected_signature = sign("#{header}.#{payload}")
      signature == expected_signature
    end
end
