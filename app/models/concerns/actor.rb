module Actor

  extend ActiveSupport::Concern

  included do
    has_many :actions
  end

  # Follows

  def follow(actionable)
    actions.where(actionable: actionable, scope: 'follow').first_or_create! if self != actionable
  end

  def unfollow(actionable)
    actions.where(actionable: actionable, scope: 'follow').destroy_all
  end

  def following?(actionable)
    actions.where(actionable: actionable, scope: 'follow').exists?
  end

  def following
    User.where_exists(:actions, scope: 'follow', user: self)
  end

  def followers
    User.where_exists(:actions, scope: 'follow', actionable: self)
  end

  # Favorites

  def favorite(actionable)
    actions.where(actionable: actionable, scope: 'favorite').first_or_create!
  end

  def unfavorite(actionable)
    actions.where(actionable: actionable, scope: 'favorite').destroy_all
  end

  def favorite?(actionable)
    actions.where(actionable: actionable, scope: 'favorite').exists?
  end

end