# encoding: UTF-8
class IndexController < ApplicationController
  def index
require 'net/http'


=begin
  str_mas = []
  @hash_mas = []
  (0..200).each do |index|
    @hash_mas << {:app_id => "8955419", :t=>"57", :m=>"11.0", :r=>"kuda.ry", :h=>"videomore_ru", :p=>"8", :s=>"DDD_#{index}"}
  end  


  @partner = Partner.find_by_app_id("8955419")
  @hash_mas.each do |params|
  
    sig = Digest::MD5.hexdigest(
              params.reject {|k,v| k == 'format' || k == 'controller' || k == 'action' || k == 'sig'}.
              collect {|key, value| "#{key}=#{value}"}.
              sort.
              join('&') + @partner.secret
           )
    params[:sig] = sig+'error'

  end
@hash_mas.each_with_index do |item|
  p item
  str_req = ""
  item.each do |k,v|
    str_req += "#{k}=#{v}&"
  end  
  str_req = str_req.slice(0,str_req.size-1) 
   uri = URI.parse("http://195.34.2.115:8081/?#{str_req}")
   @result=Net::HTTP.get(uri)
end  

=end




  
  






  	@partners = Partner.all
  	
  	@current_partner_id = session[:current_partner_id] || Partner.where(:app_id => 'html5_vm').first.id 

  	@message = "Hello, world"
  	respond_to do |format|
  	  format.html {}	
  	end 
  end	
end 

