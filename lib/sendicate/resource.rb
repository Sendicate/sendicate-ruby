require 'cgi'

module Sendicate
  
  class Resource
    include HTTParty
    base_uri 'https://api.sendicate.net/v1'
    headers 'Accept' => 'application/json', 'Content-Type' => 'application/json', "Authorization" => "token #{Sendicate.api_token}"
    
    attr_reader :attributes, :errors, :response
    
    def initialize(attributes={})
      @attributes = attributes
      @errors = {}
    end
    
    def method_missing(method, *args)
      method_string = method.to_s
      is_setter_method = method_string[-1, 1] == '='
      key = method_string.gsub(/\=/, '')
      
      if is_setter_method
        attributes[key] = args.first
      elsif attributes.include?(key)
        attributes[key]
      else
        super
      end
    end
    
    class << self
      
      def base_path(path)
        @base_path = path
      end
      
      def all
        response = get(collection_path)
        response.parsed_response.map do |attributes|
          new(attributes)
        end
      end
      
      def find(param)
        if param.nil?
          raise ResourceNotFound
        else
          response = get(member_path(param))
          new(response.parsed_response)
        end
      end
      
      def collection_path
        @base_path
      end
      
      def member_path(param)
        escaped_param = if param.is_a?(String)
          CGI::escape(param)
        else
          param
        end
        [@base_path, escaped_param].join("/")
      end
      
      def get(*args)
        Request.get(*args)
      end

      def post(*args)
        Request.post(*args)
      end

      def patch(*args)
        Request.patch(*args)
      end

      def put(*args)
        Request.put(*args)
      end

      def delete(*args)
        Request.delete(*args)
      end
    end
    
    def save
      response = if persisted?
        self.class.put(member_path, body: to_json)
      else
        self.class.post(member_path, body: to_json)
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
      response = self.class.delete(member_path)
    end
    
    def persisted?
      !to_param.nil?
    end
    
    def id
      attributes['id'] || attributes[:id]
    end
    
    def to_param
      if id.is_a?(String)
        CGI::escape(id)
      else
        id
      end
    end
    
    def to_json
      MultiJson.dump(attributes)
    end
    
    def member_path
      self.class.member_path(to_param)
    end
  end
end