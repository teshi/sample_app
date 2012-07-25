require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    it "must success" do
      get 'new'
      response.should be_success
    end
    
    it "must have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Inscription")
    end
  end

end
