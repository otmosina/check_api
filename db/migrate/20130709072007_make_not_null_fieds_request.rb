class MakeNotNullFiedsRequest < ActiveRecord::Migration
  def change
  	change_column :requests, :partner_id, :integer, :null => false
  	change_column :requests, :parametres, :string, :null => false 
  	change_column :requests, :url,   	  :string, :null => false  

  	#change_column :requests, :parametres, :partner_id, :url,   	  :null => false    		
  end
end
