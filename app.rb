require 'sinatra'
require 'sinatra/activerecord'
# require 'active_record'
require_relative './app/models/member'

begin
  require 'dotenv'
  Dotenv.load
  rescue LoadError
end

set :database, ENV['DATABASE_URL']

enable :sessions

# root route
get '/' do
  redirect '/members'
end

# index
get '/members' do
  @members = Member.all
  erb :index
end

# new
get '/members/new' do
  erb :new
end

# create
post '/members' do
  Member.create(params)
  redirect '/members'
end

# show
# The line breaks can't be at syntactic sugar-y points in the code
get '/members/:id' do
  @member = Member.find(params[:id])
  erb :show
end

# edit: gives you the form to edit the member
get '/members/:id/edit' do
  @member = Member.find(params[:id])
  erb :edit
end

# actually does the edit
# update
patch '/members/:id' do
  member = Member.find(params[:id])
  member.update(first_name: params[:first_name])
  redirect "/members/#{member.id}"
end

# deletes the member
delete '/members/:id' do
  member = Member.find(params[:id])
  member.delete
  redirect "/members"
end