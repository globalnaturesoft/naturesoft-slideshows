module Naturesoft::Slideshows
  class Slideshow < ApplicationRecord
    belongs_to :user
    has_many :slides
    
    validates :name, presence: true
    validates :width, presence: true
    validates :height, presence: true
    
    after_save :recreate_thumbs
    
    def recreate_thumbs
			slides.each do |s|
				s.recreate_thumbs
			end
		end
    
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
      if params[:keyword].present?
        params[:keyword].split(" ").each do |k|
          records = records.where("LOWER(CONCAT(naturesoft_slideshows_slideshows.name,' ',naturesoft_slideshows_slideshows.height,' ',naturesoft_slideshows_slideshows.width,' ',naturesoft_slideshows_slideshows.image_style)) LIKE ?", "%#{k.strip.downcase}%") if k.strip.present?
        end
      end
      
      # for sorting
      sort_by = params[:sort_by].present? ? params[:sort_by] : "naturesoft_slideshows_slideshows.name"
      sort_orders = params[:sort_orders].present? ? params[:sort_orders] : "asc"
      records = records.order("#{sort_by} #{sort_orders}")
      
      return records
    end
    
    # enable/disable status
    def enable
			update_columns(status: "active")
		end
    
    def disable
			update_columns(status: "inactive")
		end
    
    # data for select2 ajax
    def self.select2(params)
			items = self.search(params)
			if params[:excluded].present?
				items = items.where.not(id: params[:excluded].split(","))
			end
			options = [{"id" => "", "text" => "none"}]
			options += items.map { |c| {"id" => c.id, "text" => c.name} }
			result = {"items" => options}
		end
  end
end
