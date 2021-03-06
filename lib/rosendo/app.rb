module Rosendo
  class App
    class << self
      %w{GET POST PUT DELETE}.each do |method|
        define_method method.downcase do |*args, &block|
          routes.add(method, *args, &block)
        end
      end
      
      def run!(options = {})
        Server.new(self, options).start
      end
      
      def process(request, response)
        if route = routes.for(request)
          response.body = begin
            route.call(request, response)
          rescue Exception => e
            response.status = 500
            e.inspect + "\n\n" + e.backtrace.join("\n")
          end
        else
          response.status = 404
          response.body = "404 Not Found"
        end
      end
      
      private
      
      def routes
        @routes ||= Routes.new
      end
    end
  end
end