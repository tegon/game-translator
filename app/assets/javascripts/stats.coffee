class window.Stat
  constructor: ->
    @date_from = $('#date_from')
    @date_from.datepicker { dateFormat: 'dd/mm/yy' }

    @date_to = $('#date_to')
    @date_to.datepicker { dateFormat: 'dd/mm/yy' }

    $('form').on 'submit', (e) ->
      e.preventDefault()
      $.ajax $('form').attr('action'),
        type: 'POST',
        data: { date_from: $('#date_from').val(), date_to: $('#date_to').val() },
        success: (response) ->
          html = "<h1>#{ response.translations } traduções de #{ response.date_from } até #{ response.date_to }</h1>"
          $('.per_date').html(html)
        error: (err, response) ->
          $('.per_date').html('<br /><h2>ocorreu um erro :(</h2>')
        beforeSend: ->
          $('.per_date').addClass('ajax-loading')
          $('.per_date').html('<br /><h2>carregando...</h2>')
        complete: ->
          $('.per_date').removeClass('ajax-loading')