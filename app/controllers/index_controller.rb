# encoding: UTF-8
class IndexController < ApplicationController
  def index
  	@partners = Partner.all
  	@message = "Hello, world"
  	respond_to do |format|
  	  format.html {}	
  	end 
  end	
end 

