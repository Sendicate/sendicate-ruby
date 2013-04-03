module Sendicate
  
  class Subscriber < Resource
    base_path '/subscribers'
    
    def email
      attributes['email'] || attributes[:email]
    end
    
    def to_param
      id || email
    end
    
    def self.unsubscribe(email)
      subscriber = find(email)
      subscriber.unsubscribe
    end
    
    def unsubscribe
      self.subscribed = false
      save
    end
  end
end