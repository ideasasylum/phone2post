require 'rubygems'
require 'sinatra'
require 'phone2post'
require 'test/unit'
require 'rack/test'
require 'ftools'

begin; require 'turn'; rescue LoadError; end


set :environment, :test

class Phone2PostTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_uploads_a_file
    test_file = 'test.mp3'
    File.copy test_file, 'upload.mp3'
    post '/upload/4367803575802/1234', {:filename => {:tempfile => 'upload.mp3'}, :apikey => '1234'}
    assert last_response.ok?
  end
  
  def test_home_page
    get '/'
    assert last_response.ok?
  end
end
