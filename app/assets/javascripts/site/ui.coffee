$ ->
  setupReviews()

#  $grid-breakpoints: (
#    xs: 0,
#    sm: 388px,
#  md: 768px,
#  lg: 1148px,
#  xl: 1528px
#);
  $('.slider').slick({
    dots: false,
    infinite: false,
    slidesToShow: 8,
    slidesToScroll: 8,
    responsive: [
      {
        breakpoint: 1528,
        settings: {
          slidesToShow: 6,
          slidesToScroll: 6
        }
      },
      {
        breakpoint: 1148,
        settings: {
          slidesToShow: 4,
          slidesToScroll: 4
        }
      },
      {
        breakpoint: 768,
        settings: {
          slidesToShow: 2,
          slidesToScroll: 2
        }
      }
  ]
});

window.setupReviews = ->
  $('#review_rating').rating
    filled: 'fas fa-star text-primary',
    filledSelected: 'fas fa-star text-primary',
    empty: 'far fa-star',
    #fractions: 2


