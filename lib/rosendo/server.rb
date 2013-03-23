require 'socket'

module Rosendo
  class Server
    attr_reader :port
    def initialize(app, args = {})
      @app = app
      @port = args[:port] || '2000'
    end

    def start
      puts "== Rosendo is rocking the stage on #{port}"
      puts ">> Listening on 0.0.0.0:#{port}, CTRL+C to stop"
      
      loop do
        client = server.accept
        request = Request.new(client)
        response = Response.new(client)
        @app.process(request, response)
        response.respond
        puts "#{request.method} #{request.url} #{response.status} #{response.body.size}"
      end
    end

    def server
      @server ||= TCPServer.new(@port)
    end
  end
end
