class Link < ActiveRecord::Base
  attr_accessible :description, :name, :published, :url

  has_and_belongs_to_many :linkmaincats
  has_and_belongs_to_many :linksubcats
  has_and_belongs_to_many :linkpagecats

end
