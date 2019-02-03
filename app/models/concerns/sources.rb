module Sources

  extend ActiveSupport::Concern

  included do

    has_many :external_ids, as: :media

    scope :with_external_id, -> (source, id) { joins(:external_ids).where(source: source, external_id: id) }

    SOURCES = %w(imdb tmdb)

    SOURCES.each do |source|

      define_method(:"#{source}_id") do
        instance_variable_get("@#{source}_id") || external_ids.find{|record| record.source == source}.try(:id)
      end

      define_method(:"#{source}_id=") do |id|
        instance_variable_set "@#{source}_id", id
      end

    end

  end

end