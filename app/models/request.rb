class Request < ActiveRecord::Base
  attr_accessible :integer, :parametres, :partner_id, :url

  belongs_to :partner

  #validates :parametres, :presence => true


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
  	hash['app_id']=self.partner.app_id
  	self.parametres.split('&').each do |item|
  	  hash_key = item.split('=')[0]
  	  hash_val = item.split('=')[1]  	  	
  	  hash[hash_key] = hash_val 	
  	end	
    return hash	
  end	

  def get_full_request
  	str_parametres = parametres.to_s.blank? ? "" : '&'+parametres.to_s   
  	"http://"+self.url.to_s + '?' + 'app_id='+partner.app_id + str_parametres + '&sig='  + self.signature(self.make_parametres_str_in_hash, self.partner.secret).to_s
  end	

  def incr_count
    self.count_make += 1
    self.save
  end  

  def self.history_request
    range_updated = Time.now - 3.day
    where('updated_at > ?', range_updated)
  end  


end
