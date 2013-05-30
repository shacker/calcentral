class Linkmaincat < ActiveRecord::Base

  attr_accessible :name, :slug
  validates_uniqueness_of :name, :slug

end
