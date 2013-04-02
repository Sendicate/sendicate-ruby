require 'spec_helper'

describe Sendicate::Import do

  describe "save" do
  
    it "should import subscriber" do
      list = Sendicate::List.new(title: "Test list")
      list.save
      import = Sendicate::Import.new(
        list_id: list.id, 
        data: {
          email: 'test@mailinator.com', 
          name: 'Test subscriber'
        }
      )
      import.save.should == true
      import.failed.should == 0
      import.error_messages.should be_empty
      list.destroy
    end
    
    it "should not import invalid subscriber" do
      list = Sendicate::List.new(title: "Test list")
      list.save
      import = Sendicate::Import.new(
        list_id: list.id, 
        data: {
          email: 'test@mailinator', 
          name: 'Test subscriber'
        }
      )
      import.save.should == false
      import.failed.should == 1
      import.error_messages.should == ["Invalid email address"]
      list.destroy
    end
  end
end