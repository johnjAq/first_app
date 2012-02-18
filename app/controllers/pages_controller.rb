class PagesController < ApplicationController
	require 'net/http'
	require 'cgi'
	
	def home
	params = {:accountid => "{ACCOUNT-ID}", :key => "{ACCOUNT-KEY}"}
	domain = 'www.eiseverywhere.com'
	path = '/api/rest/authorize'
	result = http_get(domain, path, params)
	@title="Home"
	@text = result
  end

  def contact
	@title="Contact"
  end

  def about
	@title="About"
  end

  def help
	@title="Help"
  end

  def http_get(domain,path,params)
	return Net::HTTP.get(domain, "#{path}?".concat(params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&'))) unless params.nil?     
	return Net::HTTP.get(domain, path) 
  end 
  
  
end
