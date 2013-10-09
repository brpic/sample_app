require 'spec_helper'

describe User do

  before(:each) do
    @attr = {
              :nom => "example user",
              :email => "ex@user.com",
              :password => "foobar",
              :password_confirmation => "foobar"
    }
  end

  describe "password validations" do

    it "should ask a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should have a similary confirmation password" do
      User.new(@attr.merge(:password_confirmation => "invalid"))
    end

    it "should kill too short password" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "should kill too long password" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end

  describe "password_encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an attribute password_encryption" do
      @user.should respond_to(:encrypted_password)
    end

    it "should define an encrypted password" do
      @user.encrypted_password.should_not be_blank
    end

    describe "authenticate method" do

      it "should return nil if mail/pass don't match" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end

      it "should return nil if an email doesn't exist" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
      end

      it "should return user and email " do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end
    end
  end

  describe "cryptage password" do

    before(:each) do
      @user = User.create!(@attr)
    end

      describe "Methode has_password?" do
        it "should return true if password are similar" do
          @user.has_password?(@attr[:password]).should be_true
        end

        it "should return false if password are not similar" do
          @user.has_password?("invalide").should be_false
        end
      end
  end
  
  it "should create an instance with right attributes" do
    User.create!(@attr)
  end

  it "should have an existing name" do
    bad_guy = User.new(@attr.merge(:nom => ""))
    bad_guy.should_not be_valid
  end
  
  it "it should have an existing email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should unaccepted too long name" do
    long_nom = "a" * 51
    long_name_user = User.new(@attr.merge(:nom => long_nom))
    long_name_user.should_not be_valid
  end

  it "should be accept right email" do
    adresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    adresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should be kill wrong email" do
    adresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    adresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should refused double email" do
    # place un utilsiateur avec un email dans la BD
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should refused double email with different case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
end
