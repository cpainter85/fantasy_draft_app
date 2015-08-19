$ ->
  $('.game-details').hide()

  $('.game-info').hover ->
    $(@).find('.game-details').slideDown()
  , ->
    $(@).find('.game-details').slideUp()
