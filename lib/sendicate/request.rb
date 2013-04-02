module Sendicate
  
  class Request
    include HTTParty
    base_uri 'https://api.sendicate.net/v1'
    headers 'Accept' => 'application/json', 'Content-Type' => 'application/json', "Authorization" => "token #{Sendicate.api_token}"
    
    attr_accessor :response
    
    def self.get(path, options={}, &block)
      new(super)
    end
    
    def self.post(path, options={}, &block)
      new(super)
    end
    
    def self.patch(path, options={}, &block)
      new(super)
    end
    
    def self.put(path, options={}, &block)
      new(super)
    end
    
    def self.delete(path, options={}, &block)
      new(super)
    end
    
    def initialize(response)
      @response = response
      unless success?
        case response.code
        when 400
          raise Sendicate::BadRequest
        when 401
          raise Sendicate::Unauthorized
        when 404
          raise Sendicate::ResourceNotFound
        end
      end
    end
    
    def parsed_response
      response.parsed_response
    end
    
    def success?
      [200, 201].include?(response.code)
    end
  end
end