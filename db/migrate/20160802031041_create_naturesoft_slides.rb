class CreateNaturesoftSlides < ActiveRecord::Migration[5.0]
  def change
    create_table :naturesoft_slideshows_slides do |t|
      t.string :name
      t.text :description
      t.string :image
      t.references :user, references: :naturesoft_users, index: true
      t.references :slideshow, references: :naturesoft_slideshows_slideshows, index: true

      t.timestamps
    end
  end
end
