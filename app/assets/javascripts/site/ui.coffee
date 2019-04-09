$ ->
  setupReviews()

window.setupReviews = ->
  $('#review_rating').rating
    filled: 'fas fa-gem text-primary',
    filledSelected: 'fas fa-gem text-primary',
    empty: 'far fa-gem',
    #fractions: 2


