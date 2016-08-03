module Naturesoft::Slideshows
  class Slide < ApplicationRecord
    belongs_to :user
    
    def self.sort_by
      [
        ["Name","name"],
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
