module Naturesoft::Slideshows
  class Slideshow < ApplicationRecord
    belongs_to :user
    
    def self.filter_image_style
      [
        ["FILL","fill"],
        ["FIT","fit"],
      ]
    end
    def self.sort_by
      [
        ["Name","name"],
        ["Height","height"],
        ["Width","width"],
        ["Created At","created_at"]
      ]
    end
    def self.sort_orders
      [
        ["ASC","asc"],
        ["DESC","desc"]
      ]
    end
  end
end
