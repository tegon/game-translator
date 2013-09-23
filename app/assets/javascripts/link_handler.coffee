class window.LinkHandler
  constructor: ->
    @toggleSelected()
    @changeLocale()

  toggleSelected: ->
    @url = window.location.pathname
    @test = $('#nav li a[href=\"' + @url + '\"]').addClass('selected')

    if @url.match(/\/en\//)
      $('#en').addClass('selected')
    else if @url.match(/\/es\//)
      $('#es').addClass('selected')
    else
      $('#pt-BR').addClass('selected')

  changeLocale: ->
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