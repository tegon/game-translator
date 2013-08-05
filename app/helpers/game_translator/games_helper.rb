module GameTranslator::GamesHelper
  def flag(language)
    src = "/assets/flags/#{ language }.png"
    img = "<img src=#{ src }>"
    "<div class='flag'>#{ img }</div>".html_safe
  end
end