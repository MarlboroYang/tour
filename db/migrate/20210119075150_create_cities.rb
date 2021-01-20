class CreateCities < ActiveRecord::Migration[6.0]
  def change
    create_table :cities do |t|
      t.string :city_name
      t.text :content
      t.string :slug
      t.string :state, default: 'open'
      t.datetime :deleted_at
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :country, null: false, foreign_key: true

      t.timestamps
    end
    add_index :cities, :slug, unique: true
  end
end
