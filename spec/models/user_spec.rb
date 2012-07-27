require 'spec_helper'

describe User do
  before(:each) do
    @attr = { :nom                   => "Example User", 
			  :email                 => "user@example.com",
			  :password              => "supinfo",
			  :password_confirmation => "supinfo" }
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
  
  describe "password validations" do
    it "should demand a password" do
      User.new(@attr.merge( :password => "", 
                            :password_confirmation => "")).
      should_not be_valid
    end

    it "should demand a valid password_confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
      should_not be_valid
    end

    it "should reject password < 6" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "should reject password > 40" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end
    
  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have a crypted password" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should demand a crypted password" do
      @user.encrypted_password.should_not be_blank
    end
    
    describe "has_password? method" do
      it "should return true if ok" do
        @user.has_password?(@attr[:password]).should be_true
      end    

      it "should return false if not ok" do
        @user.has_password?("invalid").should be_false
      end 
    end
    
    describe "authenticate method" do
      it "should return nil if wrong login/pass" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end

      it "should return nil if user email don't exist" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
      end

      it "should return user if good login/pass" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end
    end
  end
end
