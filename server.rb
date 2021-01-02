require 'sinatra'
require 'sinatra/reloader' if development?
require 'uri'
require 'net/http'
require 'pry' if development?

class PlagChecker < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
end

get '/' do
  @body = {}
  erb :index
end

post '/check' do
  data = params["content"]
  url = URI('https://www.prepostseo.com/apis/checkPlag')
  https = Net::HTTP.new url.host, url.port;
  https.use_ssl = true
  request = Net::HTTP::Post.new url
  form_data = [['key', ENV['75648479537863d29863423c5141ec24'],['data', data]]
  request.set_form form_data, 'multipart/form-data'
  response = https.request request
  @body = JSON response.read_body

  erb :index, locals: {body: @body}
end