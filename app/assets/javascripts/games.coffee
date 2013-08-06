class window.Game
  constructor: ->
    @firstFocus()

  firstFocus: ->
    $('input:visible:enabled:first').focus()