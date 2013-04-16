require 'sinatra'
require 'json'
require './lib/ruby_executer'

get '/hi' do
  "Hello I am webirb!<br/> I can execute ruby code."
end

post "/irb/" do
  @executer = RubyExecuter.new
  @executer.execute(params[:code])
  content_type :json
  { 
    code: "#{params[:code]}", 
    output: @executer.output, 
    exception: @executer.exception, 
    result: @executer.result
  }.to_json
end