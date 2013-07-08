class Request < ActiveRecord::Base
  attr_accessible :integer, :parametres, :partner_id, :url

  belongs_to :partner

  validates :parametres, :presence => true


  def signature(parametres, secret)
    Digest::MD5.hexdigest(
              parametres.reject {|k,v| k == 'format' || k == 'controller' || k == 'action' || k == 'sig'}.
              collect {|key, value| "#{key}=#{value}"}.
              sort.
              join('&') + secret
           )
  end

  def make_parametres_str_in_hash
  	hash = {}
  	self.parametres.split('&').each do |item|
  	  hash_key = item.split('=')[0]
  	  hash_val = item.split('=')[1]  	  	
  	  hash[hash_key] = hash_val 	
  	end	
    return hash	
  end	

  def get_full_request
  	self.url.to_s + '?' + parametres.to_s + '&sig='  + self.signature(self.make_parametres_str_in_hash, self.partner.secret).to_s
  end	


end
