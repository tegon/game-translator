class window.Language
  constructor: ->
    $(game_translator_language_code).focusout ->
      value = $(this).val().toLowerCase()
      $(game_translator_language_code).val(value)