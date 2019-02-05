class Episode < Media

  belongs_to :parent, polymorphic: true

  jsonb_accessor :extra_fields,
                 production_code: :string,
                 season_number: :integer

  def name
    "S#{'%02i' % season_number}E#{'%02i' % number} #{title}"
  end

end
