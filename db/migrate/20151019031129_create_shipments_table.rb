class CreateShipmentsTable < ActiveRecord::Migration
  def up
    create_table :shipments, :force => true do |t|
      t.decimal :length
      t.decimal :width
      t.decimal :height
      t.decimal :weight
      t.text :shipping_label
    end

    create_table :addresses, :froce => true do |t|
      t.belongs_to :shipment
      t.string :role
      t.string :company
      t.string :name
      t.string :street1
      t.string :street2
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone_number
    end
  end

  def down
  end
end
