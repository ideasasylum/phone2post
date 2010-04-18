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
    test_file = File.open('test_upload', 'w')
    test_file << 'Hello'
    test_file.close
    Sinatra::Application
  end

  def test_it_uploads_a_file
    post '/upload/4367803575802/1234', {:filename => {:tempfile => 'test_upload'}, :apikey => '1234'}
    assert last_response.ok?
  end
  
  def test_home_page
    get '/'
    assert last_response.ok?
  end
end
