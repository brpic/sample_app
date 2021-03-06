require 'spec_helper'
  describe "LayoutLinks" do

    it "should find homepage at /" do
      get '/'
      response.should have_selector('title', :content => "Accueil")
    end

    it "should find about page at /about" do
      get '/about'
      response.should have_selector('title', :content => "About")
    end

    it "should find contact page at /contact" do
      get '/contact'
      response.should have_selector('title', :content => "Contact")
    end

    it "should find  help page at /help" do
      get '/help'
      response.should have_selector('title', :content => "Help")
    end

    it "should find subscribe page at /signup" do
      get '/signup'
      response.should have_selector('title', :content => "Inscription")
    end

    it "should be have the right link in the layout" do
      visit root_path
      click_link "About"
      response.should have_selector('title', :content => "About")
      click_link "Aide"
      response.should have_selector('title', :content => "Help")
      click_link "Contact"
      response.should have_selector('title', :content => "Contact")
      click_link "Accueil"
      response.should have_selector('title', :content => "Accueil")
      click_link "Inscription"
      response.should have_selector('title', :content => "Inscription")
    end
end
