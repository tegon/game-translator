class window.Stat
  constructor: ->
    @date_from = $('#date_from')
    @date_from.datepicker { dateFormat: 'dd/mm/yy' }

    @date_to = $('#date_to')
    @date_to.datepicker { dateFormat: 'dd/mm/yy' }