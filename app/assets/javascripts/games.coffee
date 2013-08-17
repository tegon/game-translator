class window.Game
  constructor: ->
    @firstFocus()

    $('dd.instructions dl dt a').click -> 
      field = $(this).parent().next()
      tag = "[#{ $(this).data('key') }]"
      Game.insertInstructionTag(tag, field)

  @insertInstructionTag: (tag, field) ->
    end = field[0].selectionEnd
    start = field[0].selectionStart
    val = field.val()

    field.val val.substring(0, start) + tag + val.substring(end, val.length)
    field[0].selectionStart = field.val().length
    field.focus()
  
  firstFocus: ->
    $('input:visible:enabled:first').focus()