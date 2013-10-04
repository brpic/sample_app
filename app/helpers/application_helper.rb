module ApplicationHelper
  # retourner un titre basé sur la page
  def titre
    base_titre = "Default title :"
    if @titre.nil?
      base_titre
    else
      "#{base_titre} | #{@titre}"
    end
  end

  def logo
    @logo = image_tag("logo.png", :alt => "Application exemple", :class => "round")
  end
end
