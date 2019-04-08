$ ->
  setupReviews()

window.setupReviews = ->
  $('input[data-rating]').rating
    filled: 'fas fa-star',
    filledSelected: 'fa-star',
    empty: 'far fa-star'


