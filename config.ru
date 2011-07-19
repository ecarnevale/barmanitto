require 'rubygems'
gem 'sinatra', "0.9.4"
require 'sinatra'

Sinatra::Application.default_options.merge!(
  :run => false,
  :env => ENV['RACK_ENV']
)

require 'app'
run Sinatra.application
