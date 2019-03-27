module ActionsHelper

  def link_to_follow(actionable)
    unless current_user == @user
      if current_user.following?(@user)
        link_to 'Unfollow', user_follow_path(@user), class: 'btn btn-primary float-right', method: :delete
      else
        link_to 'Follow', user_follow_path(@user), class: 'btn btn-primary float-right', method: :post
      end
    end
  end

  def link_to_favorite(actionable)
    if current_user.favorite?(actionable)
      link_to 'UnFavorite', [actionable, :favorite], method: :delete
    else
      link_to 'Favorite', [actionable, :favorite], method: :post
    end
  end

end