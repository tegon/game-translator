class window.Idle
  constructor: ->
    $(document).idle
      onIdle: ->
        $.ajax
          type: 'GET'
          url: '/translate/idle' 
          data: { 'games' : Idle.prototype.gameIds() } 
          success: (data) =>
            $('body').html(data) 
      idle: 900000

  gameIds: ->
    games = []
    $('dd.name input').each ->
      games.push $(this).data('game')
    games