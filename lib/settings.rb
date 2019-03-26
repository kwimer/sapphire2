class Settings

  class << self

    def name
      instance.name
    end

    private

    def method_missing(key, *args, &block)
      instance.send(key)
    end

    def instance
      @instance ||= _load(Rails.application.config_for(:settings))
    end

    def _load(hash)
      OpenStruct.new(hash.each_with_object({}) do |(key, val), memo|
        memo[key] = val.is_a?(Hash) ? _load(val) : val
      end)
    end

  end

end