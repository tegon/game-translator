class window.Game
  constructor: ->
    @firstFocus()
    @instructions = $('dd.instructions')
    @instructionField = undefined

  firstFocus: ->
    $('input:visible:enabled:first').focus()

  insertInstructionTag: (tag, element) ->
    @instructionField = $(element).parent().next()
    end = @instructionField[0].selectionEnd
    start = @instructionField[0].selectionStart
    val = @instructionField.val()

    @instructionField.val val.substring(0, start) + tag + val.substring(end, val.length)
    @instructionField[0].selectionStart = @instructionField.val().length
    @instructionField.focus()