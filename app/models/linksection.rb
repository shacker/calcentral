class Linksection < ActiveRecord::Base

  attr_accessible :linkmaincat_id
  attr_accessible :linksubcat_id
  attr_accessible :linkpagecat_id

  belongs_to :linkmaincat
  belongs_to :linksubcat
  belongs_to :linkpagecat
  has_one :link


  RailsAdmin.config do |config|
    config.model 'Linksection' do
      label "Link Sections"
    end

    # def custom_label_method
    #   "Sub Cat #{self.name}"
    # end
  end
end
