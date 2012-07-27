require 'spec_helper'

describe "Users" do
  describe "inscription" do
    describe "failed" do
      it "should not create new user" do
        lambda do
          visit signup_path
          fill_in "Nom", :with => ""
          fill_in "Email", :with => ""
          fill_in "Password", :with => ""
          fill_in "Confirmation", :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
    end
    
    describe "succeed" do
      it "should create new user" do
        lambda do
          visit signup_path
          fill_in "Nom", :with => "Example User"
          fill_in "Email", :with => "user@example.com"
          fill_in "Password", :with => "supinfo"
          fill_in "Confirmation", :with => "supinfo"
          click_button
          response.should have_selector("div.flash.success",
                                        :content => "Bienvenue")
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end
    end
  end
end
