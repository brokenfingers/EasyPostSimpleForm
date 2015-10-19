class Shipment < ActiveRecord::Base
  has_one :from_address, :class_name => 'Address', :conditions => "role = 'from'"
  has_one :to_address, :class_name => 'Address', :conditions => "role = 'to'"

  # Add validation
  # Need to add validation to ensure that shipment(parcel) attributes
  # are decimal

  # Add attr_accessible
  attr_accessible :length, :width, :height, :weight, :shipping_label

  # Returns nil if shipment failed to be created
  def self.create_shipment(shipment_attr, from_address_attr, to_address_attr)
    self.transaction do
      shipment = Shipment.create!(shipment_attr)
      from_address = Address.new(:shipment => shipment)
      from_address.update_attributes!(from_address_attr)
      to_address = Address.new(:shipment => shipment)
      to_address.update_attributes!(to_address_attr)
      label = shipment.process_shipment(from_address, to_address)
      raise ActiveRecord::Rollback if label.nil?
      shipment.shipping_label = label
      shipment.save!
      return shipment
    end
    nil
  end

  # Returns the shipping label
  def process_shipment(from_address, to_address)
    begin
      shipment_processor = ShippingProcessor.new
      shipment_processor.create_from_address(from_address.as_json)
      shipment_processor.create_to_address(to_address.as_json)
      shipment_processor.create_parcel(self.as_json)
      shipment_processor.create_shipment
      shipment_processor.buy_shipment
    rescue EasyPost::Error => e
      nil
    end
  end
end