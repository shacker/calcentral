class UserRole < ActiveRecord::Base
  attr_accessible :name, :slug, :link_ids
  belongs_to :links
end
