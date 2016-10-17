class AddLinkButtonTextToNaturesoftSlideshowsSlides < ActiveRecord::Migration[5.0]
  def change
    add_column :naturesoft_slideshows_slides, :link, :string
    add_column :naturesoft_slideshows_slides, :button_text, :string
  end
end
