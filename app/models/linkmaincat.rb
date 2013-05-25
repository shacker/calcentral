class Linkmaincat < ActiveRecord::Base
  attr_accessible :name
  # has_and_belongs_to_many :links

  RailsAdmin.config do |config|
    config.model 'Linkmaincat' do
      label "Link Main Categories"

      # object_label_method do
      #   :custom_label_method
      # end
    end

    def custom_label_method
      "Main Cat #{self.name}"
    end
  end


end
