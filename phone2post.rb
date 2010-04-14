require 'rubygems'
require 'sinatra'
require 'curb' 

set :users, {'1234' => 'hopeless'} 

get '/' do
    'Phone 2 Post'
end

post '/upload/4367803575802/:apikey' do
    apikey = params[:apikey]
    user = settings.users[apikey]
    # receive mp3 recording from Tropo
    puts params.to_yaml
    filepath = params[:filename][:tempfile].path

    
    # upload to posterous
    params = {'username' => 'hopeless', 'password' => 'Claire.'} 
    post_data = params.map {|k, v| Curl::PostField.content(k, v)} 
    post_data << Curl::PostField.file('media', filepath) 
    c = Curl::Easy.new('http://posterous.com/api/upload') 
    c.multipart_form_post = true 
    c.http_post(*post_data) 
    puts c.body_str 

end
