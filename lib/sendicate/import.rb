module Sendicate
  
  class Import
    include HTTParty
    base_uri 'https://api.sendicate.net/v1'
    headers 'Accept' => 'application/json', 'Content-Type' => 'application/json', "Authorization" => "token #{Sendicate.api_token}"
    
    attr_reader :list_id, :data, :response, :errors
    
    def initialize(attributes)
      @list_id = attributes[:list_id]
      @data = attributes[:data]
    end
    
    def save
      @response = Sendicate::Request.post("/lists/#{list_id}/subscribers", body: MultiJson.dump(data))
      success?
    end
    
    def success?
      response && response.success?
    end
    
    def imported
      parsed_response["imported"]
    end
    
    def updated
      parsed_response["updated"]
    end
    
    def failed
      parsed_response["failed"]
    end
    
    def parsed_response
      response && response.parsed_response
    end
    
    def errors
      parsed_response['errors']
    end
    
    def error_messages
      errors.map do |error|
        error['errors'].map do |e|
          e['message']
        end
      end.flatten
    end
  end
end