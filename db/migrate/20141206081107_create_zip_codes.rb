class CreateZipCodes < ActiveRecord::Migration
  def change
    create_table :zip_codes do |t|
      t.string :code
      t.references :city, index: true

      t.timestamps
    end
  end
end
