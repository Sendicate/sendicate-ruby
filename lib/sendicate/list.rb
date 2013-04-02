module Sendicate
  
  class List
    
    attr_reader :attributes, :errors
    
    def initialize(attributes={})
      @attributes = attributes
      @errors = {}
    end
    
    def method_missing(method, *args)
      method_string = method.to_s
      is_setter_method = method_string[-1, 1] == '='
      key = method_string.gsub(/\=/, '')
      
      if attributes.include?(key)
        if is_setter_method
          attributes[key] = args.first
        else
          attributes[key]
        end
      else
        super
      end
    end

    class << self
      
      def all
        response = Sendicate::Request.get("/lists")
        response.parsed_response.map do |attributes|
          new(attributes)
        end
      end
      
      def find(id)
        if id.nil?
          raise Sendicate::ResourceNotFound
        else
          response = Sendicate::Request.get("/lists/#{id}")
          new(response.parsed_response)
        end
      end
    
      def default_response_options
        { 
          query: { 
            token: Sendicate.api_token 
          }
        }
      end
    end
    
    def save
      response = if persisted?
        Sendicate::Request.post("/lists", body: to_json)
      else
        Sendicate::Request.post("/lists/#{id}", body: to_json)
      end
      
      if response.success?
        @attributes = response.parsed_response
        true
      else
        @errors = response.parsed_response
        false
      end
    end
    
    def destroy
      response = Sendicate::Request.delete("/lists/#{id}")
    end
    
    def persisted?
      id
    end
    
    def id
      attributes['id'] || attributes[:id]
    end
    
    def to_json
      MultiJson.dump(attributes)
    end
  end
end