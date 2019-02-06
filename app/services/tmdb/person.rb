module Tmdb

  class Person

    MAPPING = {
      birthday: :birth_date,
      known_for_department: :role,
      deathday: :death_date,
      id: :tmdb_id,
      name: :name,
      also_known_as: :aka,
      gender: :gender,
      biography: :biography,
      popularity: nil,
      place_of_birth: :birth_location,
      profile_path: :tmdb_profile_path,
      adult: nil,
      imdb_id: nil,
      homepage: nil
    }

    def self.import(id)

      # Person Import
      person = ::Person.external_ids_where(tmdb_id: id.to_s).first_or_initialize
      return person if person.persisted?
      sleep 0.2
      data = Tmdb::Api.person(id)
      return unless data
      MAPPING.each { |key, col| person.send("#{col}=", data[key.to_s]) if col.is_a?(Symbol) }

      # External Ids Import
      data['external_ids'].each do |key, val|
        person.send("#{key}=", val) if val && person.respond_to?(key)
      end

      person.save!

      # Images Import
      # data['images'].each do |type, images|
      #   images.each { |image| Image.add(person, data, type, image) }
      # end

      return person
    end
  end

end
