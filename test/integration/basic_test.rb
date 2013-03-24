require 'test_helper'
require 'rosendo'

class BasicTest < IntegrationTest
  def test_hello_world
    app do
      get('/') { 'Hello, World!' }
    end
    
    get '/'
    
    assert_equal(200, response.status)
    assert_equal('Hello, World!', response.body)
  end
  
  def test_simple_route
    app do
      get('/wadus') { 'Wadus' }
    end
    
    get '/wadus'
    
    assert_equal(200, response.status)
    assert_equal('Wadus', response.body)
  end
  
  def test_not_found
    app do
      get('/') { 'Hello' }
    end
    
    get '/foo'
    
    assert_equal(404, response.status)
    assert_equal('404 Not Found', response.body)
  end
  
  def test_content_size
    app do
      get('/') { 'a' * rand(1000) }
    end
    
    get '/'
    
    assert_equal(response.body.size, response.headers['content-length'][0].to_i)
  end
  
  def test_params_in_url
    app do
      get('/hello/:name/:surname') { "Hola, #{params[:name].capitalize} #{params[:surname].capitalize}"}
    end
    
    get '/hello/rosendo/mercado'
    
    assert_equal(200, response.status)
    assert_equal('Hola, Rosendo Mercado', response.body)
  end
  
  def test_read_headers
    app do
      get('/headers') { request.env['X-Wadus'] }
    end
    
    get '/headers', 'X-Wadus' => 'Wadus'
    
    assert_equal(200, response.status)
    assert_equal('Wadus', response.body)
  end
  
  def test_set_headers
    app do
      get('/headers') do
        headers('X-Wadus' => 'Wadus')
        'Header set'
      end
    end
    
    get '/headers'
    
    assert_equal(200, response.status)
    assert_equal('Header set', response.body)
    assert_equal(['Wadus'], response.headers['x-wadus'])  # header names are case insensitive per RFC,
                                                          # and Net::HTTP seems to implement this simply
                                                          # downcasing them. Also, it returns a list
  end
  
  def test_status_code
    app do
      get('/status/:code') do
        status params[:code].to_i
        "#{params[:code]} Invented Status"
      end
    end
    
    get '/status/234'
    
    assert_equal(234, response.status)
    assert_equal('234 Invented Status', response.body)
  end
  
  def test_redirect
    app do
      get('/') { redirect '/home' }
    end
    
    get '/'
    
    assert_equal(302, response.status)
    assert_equal(['/home'], response.headers['location'])
  end
  
  def test_params
    app do
      get('/params') { "a: #{params[:a]}; b: #{params[:b]}" }
    end
    
    get '/params?a=AAA&b=BBB'
    
    assert_equal(200, response.status)
    assert_equal("a: AAA; b: BBB", response.body)
  end
  
  def test_exception
    app do
      get('/exception') { raise 'Catacrocker' }
    end
    
    get '/exception'
    
    assert_equal(500, response.status)
    assert_match('Catacrocker', response.body)
    assert_match(__FILE__, response.body)
  end
end