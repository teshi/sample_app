require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new" do
    it "should succeed" do
      get :new
      response.should be_success
    end
    
    it "must have the right title" do
      get :new
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
  
  describe "POST 'create'" do
    describe "fail" do
      before(:each) do
        @attr = { :nom => "", :email => "", :password => "",
                  :password_confirmation => "" }
      end

      it "should not create user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

      it "should have the right title" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Inscription")
      end

      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    end
    
    describe "success" do

      before(:each) do
        @attr = { :nom => "New User", :email => "user@example.com",
                  :password => "foobar", :password_confirmation => "foobar" }
      end

      it "should create user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it "should redirect to user profil" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end  
      
      it "should have welcome message" do
        post :create, :user => @attr
        flash[:success].should =~ /Bienvenue dans l'Application Exemple/i
      end  
    end
  end
end
