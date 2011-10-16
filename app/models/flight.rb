class Flight < ActiveRecord::Base 
  validates_presence_of :name, :on => :create, :message => "konnte FLug nicht finden."
end
