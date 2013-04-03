require 'spec_helper'

describe Sendicate::Subscriber do
  let(:email) { 'user@example.com' }
  
  before(:all) do
    list = Sendicate::List.new(title: 'Test')
    list.save
    import = Sendicate::Import.new(
      list_id: list.id,
      data: {
        email: 'user@example.com'
      }
    )
    import.save
  end
  
  after(:all) do
    Sendicate::List.all.each do |list|
      if list.title == 'Test'
        list.destroy
      end
    end
  end
  
  describe "find" do
    
    it "should find subscriber" do
      subscriber = Sendicate::Subscriber.find(email)
      subscriber.email.should == email
    end
    
    it "should not find invalid list" do
      lambda { Sendicate::Subscriber.find('bogus@example.com') }.should raise_error(Sendicate::ResourceNotFound)
    end
  end
  
  describe "save" do
  
    it "should update subscriber" do
      subscriber = Sendicate::Subscriber.find(email)
      subscriber.email = 'anotheruser@example.com'
      subscriber.save.should be_true
      subscriber.email = email
      subscriber.save
    end
    
    it "should not update subscriber if invalid" do
      subscriber = Sendicate::Subscriber.find(email)
      subscriber.email = ""
      subscriber.save.should be_false
    end
  end
  
  describe 'unsubscribe' do
    
    it "should unsubscribe subscriber" do
      Sendicate::Subscriber.unsubscribe(email).should be_true
      subscriber = Sendicate::Subscriber.find(email)
      subscriber.subscribed.should == false
      subscriber.unsubscribed_at.should_not be_nil
    end
  end
end