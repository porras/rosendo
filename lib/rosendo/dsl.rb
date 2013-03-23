module Rosendo
  class DSL < BasicObject
    attr_reader :request, :params
    def initialize(request, response, params)
      @request = request
      @response = response
      @params = params
    end
    
    def headers(extra = {})
      @response.headers.merge!(extra)
    end
  end
end