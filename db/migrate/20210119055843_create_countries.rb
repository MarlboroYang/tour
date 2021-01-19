class CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :countries do |t|
      t.string :country_name
      t.string :slug
      t.string :state, default: 'open'
      t.datetime :deleted_at
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :countries, :slug, unique: true
  end
end
