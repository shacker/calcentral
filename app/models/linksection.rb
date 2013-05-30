class Linksection < ActiveRecord::Base

  attr_accessible :linkmaincat_id
  attr_accessible :linksubcat_id
  attr_accessible :linkpagecat_id

  belongs_to :linkmaincat
  belongs_to :linksubcat
  belongs_to :linkpagecat
  has_and_belongs_to_many :links

end
