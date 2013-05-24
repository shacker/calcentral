class Link < ActiveRecord::Base
  attr_accessible :description, :name, :published, :url

  has_and_belongs_to_many :link_menucats
  has_and_belongs_to_many :link_submenucats
  has_and_belongs_to_many :link_pagecats

end
