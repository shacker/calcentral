module MyCampuslinks

  class Linkmaincat < ActiveRecord::Base
    attr_accessible :name, :slug
    validates_uniqueness_of :name, :slug

    RailsAdmin.config do |config|
      config.model 'Linkmaincat' do
        label "Link Main Categories"
      end

      def custom_label_method
        "Main Cat #{self.name}"
      end
    end


  end
end
