class window.Idle
  constructor: ->
    $(document).idle
      onIdle: ->
        Idle.prototype.stopTranslation()
      idle: 900000

    $(window).bind 'beforeunload', ->
      Idle.prototype.stopTranslation()

    $('form').submit ->
      $(window).unbind 'beforeunload'

  stopTranslation: ->
    $.ajax
      type: 'GET'
      url: '/translate/stop' 
      data: { 'games' : @gameIds() } 
      success: (data) =>
        window.location = '/translate/idle'

  gameIds: ->
    games = []
    $('dd.name input').each ->
      games.push $(this).data('game')
    games