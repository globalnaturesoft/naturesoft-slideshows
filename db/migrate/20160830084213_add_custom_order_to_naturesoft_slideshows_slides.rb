class AddCustomOrderToNaturesoftSlideshowsSlides < ActiveRecord::Migration[5.0]
  def change
    add_column :naturesoft_slideshows_slides, :custom_order, :integer, default: 0
  end
end
