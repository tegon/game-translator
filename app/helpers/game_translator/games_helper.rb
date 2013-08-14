module GameTranslator::GamesHelper
  def instruction_icons
    icon_links = []
    %w( mouse mouse_move mouse_left mouse_scroll arrows up_down left_right up down left right space dot comma slash plus lower higher).each do |control|
      icon_links << "<a data-key='#{control}' class='key-#{control}' title='#{control}'> </a>"
    end
    icon_links.join
  end
end