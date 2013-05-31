class Linksection < ActiveRecord::Base

  attr_accessible :link_cat_id
  # attr_accessible :linkmaincat
  # attr_accessible :linksubcat_id
  # attr_accessible :linkpagecat_id

  # belongs_to :linkmaincat
  belongs_to :link_cats
  # has_and_belongs_to_many :link_cats
  # belongs_to :linksubcat
  # belongs_to :linkpagecat
  has_and_belongs_to_many :links

  # RailsAdmin.config do |config|
  #   config.model Linksection do

  #     field :link_cats, :enum do

  #       # or doing it directly inline
  #       enum do
  #         LinkCat.where("link_cat_type_id = ?", 1)
  #       end
  #     end
  #   end
  # end



end
