module Naturesoft::Slideshows
  class Slideshow < ApplicationRecord
    belongs_to :user
    
    def self.image_style
    [
      #[I18n.t('FILL'),"fill"],
      #[I18n.t('FIT'),"fit"]
      ["FILL","fill"],
      ["FIT","fit"]
    ]
  end
  end
end
