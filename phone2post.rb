require 'rubygems'
require 'sinatra'
require 'curb' 
require 'yaml'

set :users, YAML::load_file('posterous.yaml')

get '/' do
    haml :index
end

post '/upload/4367803575802/:apikey' do
    # Get user's posterous details
    apikey = params[:apikey]
    user = settings.users[apikey]
    
    # receive mp3 recording from Tropo
    file = params[:filename][:tempfile] 
    filepath = File.new(file).path if file.is_a? String  
    filepath ||= file.path

    # rename the file
    date = Date.today
    new_file = File.join(File.dirname(filepath), "#{date.to_s}.mp3")
    File.rename filepath, new_file 
    
    # upload to posterous
    posterous_params = user.merge({'title' => "Podcast #{date.to_s}", 'autopost' => '1', 
                                   'source' => 'phone2post', 
                                   'sourceLink' => 'http://phone2post.heroku.com', 
                                   'tags' => 'podcast'})
    post_data = posterous_params.map {|k, v| Curl::PostField.content(k, v)} 
    post_data << Curl::PostField.file('media', new_file) 
    c = Curl::Easy.new('http://posterous.com/api/newpost') 
    c.userpwd = "#{user['username']}:#{user['password']}"
    c.multipart_form_post = true 
    c.http_post(*post_data) 
    puts c.body_str 
end

enable :inline_templates

__END__

@@ layout
%html
  = yield


@@ index
%h1 Phone 2 Post
%p 
  A small application which allows users to record podcasts over the phone and send them to Posterous &mdash; by 
  %a(href="http://ideasasylum.com") Jamie Lawrence. 
