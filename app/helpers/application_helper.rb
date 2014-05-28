module ApplicationHelper
  
  def title
    @title.nil? ? "CoffeeBreak" : "CoffeeBreak | #{@title}"
  end
  
end
