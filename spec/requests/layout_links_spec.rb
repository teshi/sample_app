require 'spec_helper'

describe "LayoutLinks" do
  it "should find Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Accueil")
  end
  
  it "should find Contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end
  
  it "should find About page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "A Propos")
  end
  
  it "should find Help page at '/help'" do
    get '/help'
    response.should have_selector('title', :content => "Aide")
  end
  
  it "should find signup page at '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "Inscription")
  end
  
  it "should get the right link" do
    visit root_path
    click_link "A Propos"
    response.should have_selector('title', :content => "A Propos")
    click_link "Aide"
    response.should have_selector('title', :content => "Aide")
    click_link "Contact"
    response.should have_selector('title', :content => "Contact")
    click_link "Accueil"
    response.should have_selector('title', :content => "Accueil")
    click_link "S'inscrire!"
    response.should have_selector('title', :content => "Inscription")
  end
end
