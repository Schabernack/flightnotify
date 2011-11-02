class User < ActiveRecord::Base

  has_many :subscriptions
  has_many :flights, :through => :subscriptions

end
