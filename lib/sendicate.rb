require 'httparty'
require 'multi_json'

module Sendicate
  extend self
  
  autoload :Import, 'sendicate/import'
  autoload :List, 'sendicate/list'
  autoload :Request, 'sendicate/request'
  
  class << self
    attr_accessor :api_token
  end
  
  class BadRequest < StandardError
  end
  
  class ResourceNotFound < StandardError
  end
  
  class Unauthorized < StandardError
  end
end

Sendicate.api_token = ENV['SENDICATE_API_TOKEN']