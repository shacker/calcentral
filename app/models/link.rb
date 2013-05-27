class Link < ActiveRecord::Base
  attr_accessible :description, :name, :published, :url, :linksection_ids
  has_and_belongs_to_many :linksections
end
