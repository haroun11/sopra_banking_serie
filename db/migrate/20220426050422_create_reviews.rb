class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.belongs_to :serie, null: false
      t.string :user
      t.integer :stars
      t.text :review
      t.timestamps
    end
  end
end
