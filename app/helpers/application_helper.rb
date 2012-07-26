module ApplicationHelper

  # Retourner un titre basé sur la page.
  def title
    base_title = "Simple App"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  #Helper pour le logo
  def logo
    logo = image_tag("logo.png", :alt => "Application exemple", :class => "round")
  end
end
