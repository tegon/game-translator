class window.ChangeLocale
  constructor: ->
    @en = $('#en')
    @es = $('#es')
    @br = $('#pt-BR')

    @url = @getPath()

    @replacePath(@en, '/en', @url)
    @replacePath(@es, '/es', @url)
    @replacePath(@br, '', @url)

  getPath: ->
    window.location.pathname.replace('/en', '').replace('/es', '')

  replacePath: (link, locale, url) ->
    link.attr('href', "#{ locale }#{ url }")