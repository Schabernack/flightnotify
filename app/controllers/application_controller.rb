class ApplicationController < ActionController::Base
  protect_from_forgery

  require "rubygems"
  require "bundler/setup"
  require "nokogiri"
  require "open-uri"

  def index
    @response = Nokogiri::HTML(open('http://www.google.com/search?q=x3+2312'))

    @bla = []
    @response.css('.rbt').each do |foo|
      @bla << foo.content
    end
  end
end
