
  require 'sinatra'
  require 'json'

  use Rack::Logger

  before do
     content_type :json    
     headers 'Access-Control-Allow-Origin' => '*', 
  		   'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST', 'PUT', 'DELETE'],
  		   'Access-Control-Allow-Headers' => 'Content-Type'  
  end

  set :protection, false

  options '/movie' do
  	200
  end

  get '/movie' do
    { result: "Monster University" }.to_json
  end

  post '/movie' do

    begin
      params.merge! JSON.parse(request.env["rack.input"].read)
    rescue JSON::ParserError
      logger.error "Cannot parse request body." 
    end

    { result: params[:movie], seen: true, method: 'POST' }.to_json
  end

  put '/movie' do

    begin
      params.merge! JSON.parse(request.env["rack.input"].read)
    rescue JSON::ParserError
      logger.error "Cannot parse request body." 
    end

    { result: params[:movie], updated: true, method: 'PUT' }.to_json
  end

  delete '/movie' do

    begin
      params.merge! JSON.parse(request.env["rack.input"].read)
    rescue JSON::ParserError
      logger.error "Cannot parse request body." 
    end

    { result: "#{params[:movie]} deleted!", method: 'DELETE' }.to_json
  end