class Linkpagecat < ActiveRecord::Base
  attr_accessible :name, :slug
  validates_uniqueness_of :name, :slug

  RailsAdmin.config do |config|
    config.model 'Linkpagecat' do
      label "Link Page Categories"
      weight 80
    end

    def custom_label_method
      "Page Cat #{self.name}"
    end
  end

end
