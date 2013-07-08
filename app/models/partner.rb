class Partner < ActiveRecord::Base
  attr_accessible :app_id, :secret

  has_many :requests
end
