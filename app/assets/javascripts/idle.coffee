class window.Idle
  constructor: ->
    $(document).idle
      onIdle: ->
        Idle.prototype.stopTranslation()
      idle: 900000

    $(window).bind 'unload', ->
      Idle.prototype.stopTranslation()

    $('form').submit ->
      $(window).unbind 'unload'

  stopTranslation: ->
    $.ajax
      type: 'GET'
      url: '/translate/idle' 
      success: (data) =>
        window.location = '/translate/idle'