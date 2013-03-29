module Rosendo
  class Routes
    def initialize
      @routes = []
    end
    
    def <<(route)
      @routes << route
    end
    
    def for(request)
      @routes.detect { |route| route.matches?(request) }
    end
    
    def add(method, path, &block)
      self << Route.new(method, path, &block)
    end
    
    class Route
      def initialize(method, path, &block)
        @method = method
        @path = Path.new(path)
        @block = block
      end
      
      def matches?(request)
        @method == request.method &&
        @path.matches?(request.url)
      end
    
      def call(request, response)
        DSL.new(request, response, @path.params(request.url)).instance_eval(&@block)
      end
      
      class Path
        def initialize(path)
          @path = path
          @regexp, @keys = parse
        end
        
        def matches?(url)
          url = URL.new(url)
          url.path =~ @regexp
        end
        
        def params(url)
          url = URL.new(url)
          match = url.path.match(@regexp)
          {}.tap do |params|
            @keys.each_with_index do |key, i|
              params[key] = match[i + 1]
            end
          end.merge(url.query_params)
        end
        
        private
        
        def parse
          keys = []
          pattern = @path.gsub(/:(\w+)/) do |match|
            keys << $1.to_sym
            '(\w+)'
          end
          [Regexp.new("^#{pattern}$"), keys]
        end
        
        class URL
          attr_reader :path
          def initialize(url)
            @url = url
            @path, @query = url.split('?')
          end
          
          def query_params
            return {} unless @query
            {}.tap do |params|
              @query.split('&').each do |pair|
                k, v = pair.split('=')
                params[k.to_sym] = v
              end
            end
          end
        end
      end
    end
  end
end