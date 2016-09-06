module Naturesoft::Slideshows
  class Slide < ApplicationRecord
		include Naturesoft::CustomOrder
		
		validates :image, presence: true
		validates :image, allow_blank: true, format: {
			with: %r{\.(gif|jpg|png)\Z}i,
			message: 'must be a URL for GIF, JPG or PNG image.'
		}
		validates :name, presence: true
		validates :slideshow_id, presence: true
		
		mount_uploader :image, Naturesoft::Slideshows::SlideUploader		
		
    belongs_to :user
		belongs_to :slideshow
		
		after_save :recreate_thumbs
    
    def recreate_thumbs
			self.image.recreate_versions!
		end
    
    def self.sort_by
      [
				["Custom order","naturesoft_slideshows_slides.custom_order"],
        ["Name","naturesoft_slideshows_slides.name"],
        ["Created At","naturesoft_slideshows_slides.created_at"]
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
      
      if params[:slideshow_id].present?
        records = records.where(slideshow_id: params[:slideshow_id])
      end
      
      #Search keyword filter
      if params[:keyword].present?
        params[:keyword].split(" ").each do |k|
          records = records.where("LOWER(CONCAT(naturesoft_slideshows_slides.name,' ',naturesoft_slideshows_slides.description)) LIKE ?", "%#{k.strip.downcase}%") if k.strip.present?
        end
      end
      
      # for sorting
      sort_by = params[:sort_by].present? ? params[:sort_by] : "naturesoft_slideshows_slides.name"
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
  end
end
