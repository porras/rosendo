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
    
    def status(code)
      @response.status = code
    end
    
    def redirect(url, code = 302, content = "")
      status code
      headers 'Location' => url
      content
    end
  end
end