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

      object_label_method do
        :link_section_label_method
      end

    end

    def link_section_label_method
      "#{self.linkmaincat.name} / #{self.linksubcat.name} / #{self.linkpagecat.name}"
    end

  end
end
