module Tmdb
  module Credit

    MAPPING = {
      cast_id: nil,
      character: :character,
      credit_id: :tmdb_id,
      department: :department,
      gender: nil,
      id: nil,
      job: :job,
      name: nil,
      order: nil,
      profile_path: nil
    }

    def self.add(parent, media, type, data)

      # Import Credit
      credit = ::Credit.external_ids_where(tmdb_id: data['credit_id']).first_or_initialize
      credit.media = parent
      person = Person.import(data['id'])
      return unless person
      credit.person = person
      credit.credit_type = type
      MAPPING.each { |key, col| credit.send("#{col}=", data[key.to_s]) if col.is_a?(Symbol) }
      credit.save!

      # Attach Credit
      media_credit = ::MediaCredit.where(media: media, credit: credit).first_or_initialize
      media_credit.position = data['order'] + 1 if data['order']
      media_credit.save!

      return credit
    end

  end
end
