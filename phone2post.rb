require 'rubygems'
require 'sinatra'
require 'curb' 

set :users, YAML::parse_file('posterous.yaml')

get '/' do
    haml :index
end

post '/upload/4367803575802/:apikey' do
    apikey = params[:apikey]
    user = settings.users[apikey]
    # receive mp3 recording from Tropo
    puts params.to_yaml
    file = params[:filename][:tempfile].path

    # rename the file
    date = Date.today.to_s
    new_file = File.join(File.dirname(file), date+'.mp3')
    File.rename file, new_file 
    
    # upload to posterous
    posterous_params = {'title' => 'my test post', 
                'autopost' => '1', 'source' => 'phone2post', 'sourceLink' => 'http://phone2post.heroku.com',
                'tags' => 'podcast'}.merge user 
    post_data = posterous_params.map {|k, v| Curl::PostField.content(k, v)} 
    post_data << Curl::PostField.file('media', new_file) 
    c = Curl::Easy.new('http://posterous.com/api/upload') 
    c.multipart_form_post = true 
    c.http_post(*post_data) 
    puts c.body_str 
end


__END__

@@ layout
%html
  = yield


@@ index
%h1 Phone 2 Post
%p 
  A small application by 
  %a(href="http://ideasasylum.com") Jamie Lawrence
