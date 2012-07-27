require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new" do
    it "should succeed" do
      get 'new'
      response.should be_success
    end
    
    it "must have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Inscription")
    end
  end
  
  describe "GET 'show'" do
    before(:each) do
      @user = Factory(:user)
    end
    
    it "must succeed" do
      get :show, :id => @user
      response.should be_success
    end
    
    it "must find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
     
     it "must have the right name" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.nom)
    end

    it "must include login" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.nom)
    end

    it "must have an avatar" do
      get :show, :id => @user
      response.should have_selector("h1>img", :class => "gravatar")
    end
  end
end
