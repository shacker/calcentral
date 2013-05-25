class Link < ActiveRecord::Base
  attr_accessible :description, :name, :published, :url, :linksection_id
  belongs_to :linksection
end
