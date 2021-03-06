require 'action_controller/railtie'

class TestApp < Rails::Application
  config.root = File.dirname(__FILE__)
  config.session_store :cookie_store, key: 'cookie_store_key'
  secrets.secret_token    = 'secret_token'
  secrets.secret_key_base = 'secret_key_base'
  config.logger = Logger.new($stdout)
  Rails.logger  = config.logger

  routes.draw do
    resources :users, param: :'name/:sneaky', only: :show, format: false
  end

  puts(routes.routes.collect {|r| [r.verb, r.path.spec.to_s] })
  File.write('./viz.html', Rails.application.routes.router.visualizer)
end

class UsersController < ActionController::Base
  def show
    render plain: "#{params[:name]} : #{params[:sneaky]}"
  end
end

require 'minitest/autorun'
require 'rack/test'

class BugTest < Minitest::Test
  include Rack::Test::Methods

  def test_returns_success
    get '/users/alice/sneaky'
    puts last_response.body
    assert last_response.ok?
  end

  private

  def app
    Rails.application
  end
end
