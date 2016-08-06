module Naturesoft::Slideshows
  class Slideshow < ApplicationRecord
    belongs_to :user
    validates :name, presence: true
    validates :width, presence: true
    validates :height, presence: true
    
    def self.filter_image_style
      [
        ["FILL","fill"],
        ["FIT","fit"],
      ]
    end
    def self.sort_by
      [
        ["Name","naturesoft_slideshows_slideshows.name"],
        ["Height","naturesoft_slideshows_slideshows.height"],
        ["Width","naturesoft_slideshows_slideshows.width"],
        ["Created At","naturesoft_slideshows_slideshows.created_at"]
      ]
    end
    def self.sort_orders
      [
        ["ASC","asc"],
        ["DESC","desc"]
      ]
    end
    
    #Filter, Sort
    def self.search(params)
      records = self.all
      
      if params[:style].present?
        records = records.where(image_style: params[:style])
      end
      
      #Search keyword filter
      if params[:key].present?
        params[:key].split(" ").each do |k|
          records = records.where("LOWER(CONCAT(naturesoft_slideshows_slideshows.name,' ',naturesoft_slideshows_slideshows.height,' ',naturesoft_slideshows_slideshows.width,' ',naturesoft_slideshows_slideshows.image_style)) LIKE ?", "%#{k.strip.downcase}%") if k.strip.present?
        end
      end
      
      # for sorting
      sort_by = params[:sort_by].present? ? params[:sort_by] : "naturesoft_slideshows_slideshows.name"
      sort_orders = params[:sort_orders].present? ? params[:sort_orders] : "asc"
      records = records.order("#{sort_by} #{sort_orders}")
      
      return records
    end
  end
end
