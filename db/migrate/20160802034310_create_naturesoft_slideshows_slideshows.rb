class CreateNaturesoftSlideshowsSlideshows < ActiveRecord::Migration[5.0]
  def change
    create_table :naturesoft_slideshows_slideshows do |t|
      t.string :name
      t.integer :height
      t.integer :width
      t.string :image_style
      t.string :status, :default => "active"
      t.references :user, references: :naturesoft_users, index: true

      t.timestamps
    end
  end
end
