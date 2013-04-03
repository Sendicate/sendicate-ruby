require 'spec_helper'

describe Sendicate::List do
  
  describe "new" do
    
    it "should create list" do
      list = Sendicate::List.new(title: "Test list")
      list.save.should be_true
      list.id.should_not be_nil
    end
    
    it "should not create list if invalid" do
      list = Sendicate::List.new
      list.save.should be_false
      list.id.should be_nil
    end
    
    it "should have errors if invalid" do
      list = Sendicate::List.new
      list.save.should be_false
      list.errors.should == {"title"=>["can't be blank"]}
    end
  end
  
  describe "all" do
    
    it "should return all lists" do
      lists = Sendicate::List.all
      lists.size.should_not == 0
    end
  end
  
  describe "find" do
    let(:list_id) { Sendicate::List.all.first.id }
    
    it "should find list" do
      list = Sendicate::List.find(list_id)
      list.id.should == list_id
    end
    
    it "should not find invalid list" do
      lambda { Sendicate::List.find('bogus') }.should raise_error(Sendicate::ResourceNotFound)
    end
  end
  
  describe "save" do
  
    it "should update list" do
      list = Sendicate::List.new(title: "Test list")
      list.save
      list.title = "Test list updated"
      list.save.should be_true
    end
    
    it "should not update list if invalid" do
      list = Sendicate::List.new(title: "Test list")
      list.save
      list.title = ""
      list.save.should be_false
    end
  end
  
  describe "destroy" do
      
    it "should destroy list" do
      list = Sendicate::List.all.each do |list|
        if list.title == 'Test list' || list.title == 'Test list updated'
          list.destroy.should be_true
        end
      end
    end
  end
end