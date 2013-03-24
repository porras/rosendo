require 'minitest/unit'
require 'minitest/autorun'
require 'net/http'
require 'uri'

module TestHelper
  module IntegrationHelper
    PORT = 2600
    BASE_URL = "http://localhost:#{PORT}"
    
    def app(&block)
      Thread.current[:app] = Thread.new do
        Class.new(Rosendo::App, &block).run!(port: PORT, out: File.open(File::NULL, "w"))
      end
      sleep (ENV['WAIT'] && ENV['WAIT'].to_f) || 0.001
    end
    
    def get(path, headers = {})
      uri = URI.parse(BASE_URL + path)
      http = Net::HTTP.new(uri.host, uri.port)
      response = http.get(path, headers)
      @last_response = Response.new(response)
    end
    
    def response
      @last_response
    end
    
    class Response
      def initialize(response)
        @response = response
      end
      
      def body
        @response.body
      end
      
      def status
        @response.code.to_i
      end
      
      def headers
        @response.to_hash
      end
    end
  end
end

class UnitTest < MiniTest::Unit::TestCase
  include TestHelper
end

class IntegrationTest < UnitTest
  include IntegrationHelper
  
  def teardown
    return unless app = Thread.current[:app]
    app.raise Rosendo::Server::Stop
  end
end
