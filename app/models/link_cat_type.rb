class LinkCatType < ActiveRecord::Base

  attr_accessible :name
  validates_uniqueness_of :name
  # has_many :link_cats, :inverse_of => :link_cat_types
  has_many :link_cats

end
