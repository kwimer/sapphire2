class Settings

  def self.method_missing(key, *args, &block)
    @settings ||= Rails.application.config_for(:settings)
    @settings[key.to_s]
  end

end