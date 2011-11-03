class Subscription < ActiveRecord::Base

  belongs_to :flight, :dependent => :destroy
  belongs_to :user
  
end
