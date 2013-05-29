module MyCampuslinks
  class Link < ActiveRecord::Base
    attr_accessible :description, :name, :published, :url, :linksection_ids, :user_role_ids
    validates_uniqueness_of :url

    has_and_belongs_to_many :linksections
    has_and_belongs_to_many :user_roles
  end
end
