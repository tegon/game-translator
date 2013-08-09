module GameTranslator::LanguagesHelper
  def flag(language)
    src = "/flags/#{ language }.png"

    if File.exist?("#{ Rails.root }/app/assets/images#{ src }")  
      src = "/assets#{ src }"
      "<img src=#{ src }>".html_safe
    end
  end
end