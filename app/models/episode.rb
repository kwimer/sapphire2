class Episode < Media

  normalize_attributes :production_code
  friendly_id :episode_code, use: :scoped, scope: [:season_id]

  jsonb_accessor :extra_fields,
                 runtime: :integer,
                 season_number: :integer,
                 production_code: :string

  belongs_to :season

  def episode_code
    "S#{'%02i' % season_number}E#{'%02i' % number} #{title}"
  end

end
