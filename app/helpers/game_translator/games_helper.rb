module GameTranslator::GamesHelper
  def flag(language)
    src = "/flags/#{ language }.png"

    if FileTest.exist?("#{ Rails.root }/app/assets/images#{ src }")  
      src = "/assets#{ src }"
      "<img src=#{ src }>".html_safe
    end
  end
end