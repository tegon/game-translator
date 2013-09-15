# encoding: UTF-8
module GameTranslator::LanguagesHelper
  def flag(language)
    src = "/flags/#{ language }.png"

    if File.exist?("#{ Rails.root }/app/assets/images#{ src }")  
      src = "/assets#{ src }"
      "<img src=#{ src }>".html_safe
    end
  end

  def full_name(language)
    return "Português" if language == :"pt-BR"
    GameTranslator::Language.where(code: language).pluck(:name).first
  end
end