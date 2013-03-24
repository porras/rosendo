require 'socket'

module Rosendo
  class Server
    class Stop < Exception; end
    
    attr_reader :port, :out
    def initialize(app, args = {})
      @app = app
      @port = args[:port] || '2000'
      @out = args[:out] || STDOUT
    end

    def start
      out.puts "== Rosendo is rocking the stage on #{port}"
      out.puts ">> Listening on 0.0.0.0:#{port}, CTRL+C to stop"
      
      loop do
        begin
          client = server.accept
          request = Request.new(client)
          response = Response.new(client)
          @app.process(request, response)
          response.respond
          out.puts "#{request.method} #{request.url} #{response.status} #{response.body.size}"
        rescue Stop
          server.close
          out.puts "== Rosendo has left the building (everybody goes crazy)"
        end
      end
    end

    def server
      @server ||= TCPServer.new(@port)
    end
  end
end
