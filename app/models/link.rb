class Link < ActiveRecord::Base
  attr_accessible :description, :name, :published, :url, :linksection_id

  belongs_to :linksection

  # Without these, rails_admin won't draw the multi-select widget
  # attr_accessible :linkmaincat_ids
  # attr_accessible :linksubcat_ids
  # attr_accessible :linkpagecat_ids

end
