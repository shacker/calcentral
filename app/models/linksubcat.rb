class Linksubcat < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :links

  RailsAdmin.config do |config|
    config.model 'Linksubcat' do
      label "Link Subcategories"

      # object_label_method do
      #   :custom_label_method
      # end
    end

    def custom_label_method
      "Sub Cat #{self.name}"
    end
  end
end
