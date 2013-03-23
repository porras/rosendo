module Rosendo
  class Request
    attr_reader :method, :url, :headers
    alias_method :env, :headers
    def initialize(io)
      @io = io
      @method, @url = @io.gets.match(%r{(GET|POST|PUT|DELETE)\s(.+)\sHTTP/1\.1})[1..2]
      @headers = read_headers
    end

    def params
      {}
    end

    private
    
    def read_headers
      {}.tap do |h|
        while line = @io.gets.chomp
          break if line.empty?
          m = line.match(%r{^([\w\-]+):\s(.+)$})
          h[m[1]] = m[2]
        end
      end
    end
  end
end
