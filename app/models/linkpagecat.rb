class Linkpagecat < ActiveRecord::Base
  attr_accessible :name, :slug

  RailsAdmin.config do |config|
    config.model 'Linkpagecat' do
      label "Link Page Categories"
    end

    def custom_label_method
      "Page Cat #{self.name}"
    end
  end

end
