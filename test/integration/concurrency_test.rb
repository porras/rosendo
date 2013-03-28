require 'test_helper'
require 'rosendo'
require 'benchmark'

class ConcurrencyTest < IntegrationTest
  REQUESTS = 10
  FACTOR = 0.02
  # This test is really oversimplistic. It checks that requests are processed concurrently checking
  # that the total time is around the time for the longest request instead of the sum of all
  # requests. (Before applying FACTOR, those numbers would be 10 and 1 + 2 + ... + 10 = 55)
  def test_concurrent_requests
    app do
      get '/sleep/:i' do
        t = params[:i].to_i * FACTOR
        sleep t
        "Slept #{t}"
      end
    end
    
    time = Benchmark.realtime do
      (1..REQUESTS).map do |i|
        Thread.new(i) do |i|
          get "/sleep/#{i}"
        
          assert_equal(200, response.status)
          assert_equal("Slept #{i * FACTOR}", response.body)
        end
      end.each(&:join)
    end
    
    assert_in_delta REQUESTS * FACTOR, time, 0.05 # 0.05 is a empirically found ‘overhead’ time
  end
end