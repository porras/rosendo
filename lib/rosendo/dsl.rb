module Rosendo
  class DSL < BasicObject
    attr_reader :request
    def initialize(request, response)
      @request = request
      @response = response
    end
    
    def headers(extra = {})
      @response.headers.merge!(extra)
    end
  end
end