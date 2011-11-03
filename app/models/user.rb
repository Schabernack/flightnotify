class User < ActiveRecord::Base                  

  has_many :subscriptions
  has_many :flights, :through => :subscriptions
  
  attr_accessible :mail                         
  
  validates_presence_of :mail, :on => :create, :message => "can't be blank"

end
