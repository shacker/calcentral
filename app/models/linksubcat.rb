class Linksubcat < ActiveRecord::Base
  attr_accessible :name, :slug

  RailsAdmin.config do |config|
    config.model 'Linksubcat' do
      label "Link Subcategories"
    end

    def custom_label_method
      "Sub Cat #{self.name}"
    end
  end
end
