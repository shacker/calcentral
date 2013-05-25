class Link < ActiveRecord::Base
  attr_accessible :description, :name, :published, :url

  has_and_belongs_to_many :linkmaincats
  has_and_belongs_to_many :linksubcats
  has_and_belongs_to_many :linkpagecats

  # Without these, rails_admin won't draw the multi-select widget
  attr_accessible :linkmaincat_ids
  attr_accessible :linksubcat_ids
  attr_accessible :linkpagecat_ids

end
