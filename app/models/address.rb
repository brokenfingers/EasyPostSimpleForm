class Address < ActiveRecord::Base
  belongs_to :shipment

  Address::TYPES = %w(from to)

  # Add validation
  validates_inclusion_of :role, :in => TYPES
  # Need to add other validations such as telephone number format

  # Add attr_accessible
  attr_accessible :shipment, :company, :role, :name, :street1, :street2, :city, :state, :zip, :phone_number
end