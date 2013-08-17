class window.Idle
  constructor: ->
    console.log @gameIds()

    $(document).idle
      onIdle: ->
        console.log 'idle'
        window.location = '/translate/idle'
      idle: 900000

  gameIds: ->
    games = []
    $('dd.name input').each ->
      games.push $(this).data('game')
    games