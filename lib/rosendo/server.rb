require 'socket'

module Rosendo
  class Server
    class Stop < Exception; end
    
    def initialize(app, args = {})
      @app = app
      @port = args[:port] || '2000'
      @out = args[:out] || STDOUT
    end

    def start
      @out.puts "\n== Rosendo is rocking the stage on #{@port}"
      @out.puts ">> Listening on 0.0.0.0:#{@port}, CTRL+C to stop"
      
      begin
        while client = server.accept
          Thread.new(client) do |client|
            request = Request.new(client)
            response = Response.new(client)
            @app.process(request, response)
            response.respond
            @out.puts "#{request.method} #{request.url} #{response.status} #{response.body.size}"
          end
        end
      rescue Stop, Interrupt
        server.close
        @out.puts "\n>> Closing 0.0.0.0:#{port}..."
        @out.puts "== Rosendo has left the building (everybody goes crazy)"
      end
    end
    
    private
    
    def server
      @server ||= TCPServer.new(@port)
    end
  end
end
