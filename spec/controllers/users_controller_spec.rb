require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector('title', :content => "Inscription")
    end
  end

  describe "GET 'show'" do

    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it "should pass" do
      get :show, :id => @user
      response.should be_success
    end

    it "should find right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end

    it "should have right title" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.nom)
    end

    it "should include user name" do
      get :show,:id => @user
      response.should have_selector("h1", :content => @user.nom)
    end

    it "should have profile pic" do
      get :show, :id => @user
      response.should have_selector("h1>img", :class => "gravatar")
    end
  end
end
