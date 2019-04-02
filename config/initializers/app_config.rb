APP_CONFIG = {}
ENV.to_hash.symbolize_keys.each do |key, value|
  APP_CONFIG[key] = case value.to_s.downcase
                    when 'true'
                      true
                    when 'false'
                      false
                    else
                      value
                    end
end
