require 'spec_helper'

describe ClassifiedsController do

  #Delete these examples and add some real ones
  it "should use ClassifiedsController" do
    controller.should be_an_instance_of(ClassifiedsController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      get 'edit'
      response.should be_success
    end
  end

  describe "GET 'my_items'" do
    it "should be successful" do
      get 'my_items'
      response.should be_success
    end
  end

  describe "GET 'borrowed_items'" do
    it "should be successful" do
      get 'borrowed_items'
      response.should be_success
    end
  end
end