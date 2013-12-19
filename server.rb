require 'sinatra'
require 'sinatra/base'
require 'mongo'
require 'json/ext'

include Mongo

before do
  content_type :json    
  headers 'Access-Control-Allow-Origin' => '*', 
	  'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST'],
	  'Access-Control-Allow-Headers' => 'Content-Type'  
end

set :protection, false

# connecting to the database and so on..
conn = Mongo::Connection.new
# set database..
db   = conn['webdb']
# set the collection..
coll = db['users']				


#get a list of users...
get '/users'  do
  coll.find.to_a.to_json
end

options '/users' do
  200
end

get '/' do
  redirect '/users'
end

# get a user by ID
get '/user/:id'  do
  coll.find_one(:_id => params[:id].to_i).to_json
end

# update a user by ID
put '/user/:id' do
  id = params[:_id].to_i
  coll.update({:_id => id}, {"$set" => {
				:name    => params[:name],
				:address => params[:address],
				:city    => params[:city],
				:country => params[:country],		
				:email   => params[:email],
				:phone   => params[:phone].to_i
				}})
  coll.find_one(:_id => id).to_json
end

# post a new users
post '/user' do
  id = params[:_id].to_i
  coll.insert({
	:_id     => id,
	:name    => params[:name],
	:address => params[:address],
	:city    => params[:city],
	:country => params[:country],		
	:email   => params[:email],
	:phone   => params[:phone].to_i
  })
  coll.find_one(:_id => id).to_json
end
