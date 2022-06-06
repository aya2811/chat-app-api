require 'Encryptor.rb'
module TokenManager
    include Encryptor

    def generate_token(app_id)
        token = encrypt_string(app_id)
        return token 
    end

    def decrypt_token(token)
        if token.nil? || token.empty?
            return false
        end
        d = {}
        d_token = token.split('.').each_with_index do |item, index|
        case index
            when 0
                d[:id] = decrypt_string(item)
            when 1
                d[:name] = decrypt_string(item)
            end
        end

        return d
    end

end
