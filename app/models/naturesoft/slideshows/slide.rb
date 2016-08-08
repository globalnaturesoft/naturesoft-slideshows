module Naturesoft::Slideshows
  class Slide < ApplicationRecord
    belongs_to :user
		belongs_to :slideshow
		
		validates :name, presence: true
		validates :image, presence: true
		validates :image, allow_blank: true, format: {
			with: %r{\.(gif|jpg|png)\Z}i,
			message: 'must be a URL for GIF, JPG or PNG image.'
		}
		mount_uploader :image, Naturesoft::Slideshows::SlideUploader
    
    def self.sort_by
      [
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
    
    # change status
    def enable
			if status == "active"
				update_columns(status: "inactive")
			end
		end
    
    def disable
			if status == "inactive"
				update_columns(status: "active")
			end
		end
  end
end
