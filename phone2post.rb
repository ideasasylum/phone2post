require 'rubygems'
require 'sinatra'

 
set :users, {'1234' => 'hopeless'} 

get '/' do
'Phone 2 Post'
end

post '/upload/:apikey' do
"Hello #{params[:apikey]} #{settings.users['1234']}"
puts params.to_yaml
params[:filename][:filename]
end
