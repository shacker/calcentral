class LinkCat < ActiveRecord::Base

  attr_accessible :name, :slug, :link_cat_type_id, :linksection_id
  # We can have multiple records with the same name, but not in the same category (:scope)
  validates_uniqueness_of :name, :scope => :link_cat_type_id
  validates_uniqueness_of :slug, :scope => :link_cat_type_id
  belongs_to :link_cat_type, :inverse_of => :link_cats
  belongs_to :linksection

end
