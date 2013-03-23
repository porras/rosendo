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
      @io.puts body
      @io.close
    end

    def status_line
      "HTTP/1.1 #{status}"
    end

    def header_lines
      {'Content-Length' => body.size + 1}.merge(@headers).map { |k, v| "#{k}: #{v}" }.join("\n")
    end

  end
end