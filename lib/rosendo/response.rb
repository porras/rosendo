module Rosendo
  class Response
    attr_accessor :status, :headers, :body
    def initialize(io)
      @io = io
      @headers = {}
    end
    
    def status
      @status || 200
    end
    
    def body
      @body || ''
    end
    
    def respond
      @io.puts status_line
      @io.puts header_lines
      @io.puts
      @io.write body # write instead of puts for no extra newline
      @io.close
    end

    def status_line
      "HTTP/1.1 #{status}"
    end

    def header_lines
      {'Content-Length' => body.size}.merge(@headers).map { |k, v| "#{k}: #{v}" }.join("\n")
    end

  end
end