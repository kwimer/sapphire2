module ActionsHelper

  def link_to_follow(actionable)
    unless current_user == @user
      if current_user.following?(@user)
        link_to 'Unfollow', user_follow_path(@user), class: 'btn btn-primary float-right', method: :delete, remote: true, id: dom_id(actionable, :follow)
      else
        link_to 'Follow', user_follow_path(@user), class: 'btn btn-primary float-right', method: :post, remote: true, id: dom_id(actionable, :follow)
      end
    end
  end

  def link_to_favorite(actionable)
    if current_user && current_user.favorite?(actionable)
      link_to icon_tag('heart', class: 'fas'), [actionable, :favorite], method: :delete, remote: true, id: dom_id(actionable, :favorite)
    else
      link_to icon_tag('heart', class: 'far'), [actionable, :favorite], method: :post, remote: true, id: dom_id(actionable, :favorite)
    end
  end

  def link_to_watchlist(actionable)
    if current_user && current_user.favorite?(actionable)
      link_to icon_tag('plus-square', class: 'fas'), [actionable, :favorite], method: :delete, remote: true
    else
      link_to icon_tag('plus-square', class: 'far'), [actionable, :favorite], method: :post, remote: true
    end
  end

end