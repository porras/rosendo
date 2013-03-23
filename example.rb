require './lib/rosendo'

class Example < Rosendo::App
  get '/' do
    'Hola mundo'
  end
  
  get '/wadus' do
    'Hola wadus'
  end
  
  get '/hello/:name/:surname' do
    "#{params[:surname]}, #{params[:name]}"
  end
  
  get '/berlin' do
    'Hola Berlin'
  end
  
  get '/headers' do
    headers 'X-Wadus' => 'Wadus!!'
    "Received headers: #{request.env.inspect}"
  end
  
  get '/status/:code' do
    status params[:code].to_i
    "#{params[:code]} Invented Status"
  end
end

Example.run!(port: 2000)
