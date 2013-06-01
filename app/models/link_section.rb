class LinkSection < ActiveRecord::Base

  attr_accessible :link_main_cat_id
  attr_accessible :link_sub_cat_id
  attr_accessible :link_page_cat_id

  # This class is related to another class via three different names
  belongs_to :link_main_cat, :foreign_key => "link_main_cat_id", :class_name => "LinkCategory"
  belongs_to :link_sub_cat, :foreign_key => "link_sub_cat_id", :class_name => "LinkCategory"
  belongs_to :link_page_cat, :foreign_key => "link_page_cat_id", :class_name => "LinkCategory"

  validates :link_main_cat, :presence  => true
  validates :link_sub_cat, :presence  => true
  validates :link_page_cat, :presence  => true

end
