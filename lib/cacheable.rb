module Calcentral

  module Cacheable

    def fetch_from_cache(id = nil)
      key = id ? self.cache_key(id) : self.global_cache_key
      Rails.logger.debug "#{self.name} cache_key will be #{key}, expiration #{self.expires_in}"
      Rails.cache.fetch(
          key,
          :expires_in => self.expires_in
      ) do
        yield
      end
    end

    def expires_in
      expirations = Settings.cache.expiration.marshal_dump
      exp = expirations[self.name.to_sym] || expirations[:default]
      [exp, Settings.cache.maximum_expires_in].min
    end

    def cache_key(uid)
      "user/#{uid}/#{self.name}"
    end

    def global_cache_key()
      "global/#{self.name}"
    end

    def expire(id = nil)
      key = id ? self.cache_key(id) : self.global_cache_key
      Rails.cache.delete(key, :force => true)
      Rails.logger.debug "Expired cache_key #{key}"
    end

  end

end
