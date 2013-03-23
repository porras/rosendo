require './lib/rosendo'

class Example < Rosendo::App
  get '/' do
    'Hola mundo'
  end
  
  get '/wadus' do
    'Hola wadus'
  end
  
  get '/berlin' do
    'Hola Berlin'
  end
  
  get '/headers' do
    headers 'X-Wadus' => 'Wadus!!'
    "Received headers: #{request.env.inspect}"
  end
end

Example.run!(port: 2000)
