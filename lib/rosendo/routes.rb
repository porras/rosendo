module Rosendo
  class Routes
    def initialize
      @routes = []
    end
    
    def <<(route)
      @routes << route
    end
    
    def for(request)
      @routes.detect do |route|
        route.method == request.method &&
        route.url == request.url
      end
    end
    
    def add(method, url, &block)
      self << Route.new(method, url, &block)
    end
    
    class Route
      attr_reader :method, :url
      def initialize(method, url, &block)
        @method = method
        @url = url
        @block = block
      end
    
      def call(request, response)
        DSL.new(request, response).instance_eval(&@block)
      end
    end
  end
end