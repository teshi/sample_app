require 'spec_helper'

describe User do
  before(:each) do
    @attr = { :nom => "Example User", :email => "user@example.com"}
  end
  
  it "should create new instance with valid attributes" do
    User.create!(@attr)
  end
  
  it "should demand a name" do
    no_name = User.new(@attr.merge(:nom => ""))
    no_name.should_not be_valid
  end
  
  it "should demand an email" do
    no_email = User.new(@attr.merge(:email => ""))
    no_email.should_not be_valid
  end
  
  it "should have name < 50" do
    long_max = "a" * 51
    long_name = User.new(@attr.merge(:nom => long_max))
    long_name.should_not be_valid
  end
  
  it "should accept a valid email" do
    adresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    adresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject an invalid email" do
    adresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    adresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
 it "should reject a duplicate email case insensitive" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    duplicate_email = User.new(@attr)
    duplicate_email.should_not be_valid
  end
end
