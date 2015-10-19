class ShippingProcessor
  require 'easypost'

  attr_reader :from_address, :to_address, :parcel, :shipment

  def initialize
    EasyPost.api_key = 'cyfA9CRdHO4vyUx0DV59gQ'
  end

  def create_from_address(attr_hash)
    @from_address = EasyPost::Address.create(
      :company => attr_hash['company'],
      :street1 => attr_hash['street1'],
      :street2 => attr_hash['street2'],
      :city => attr_hash['city'],
      :state => attr_hash['state'],
      :zip => attr_hash['zip'],
      :phone => attr_hash['phone_number']
    )
  end

  def create_to_address(attr_hash)
    @to_address = EasyPost::Address.create(
      :name => attr_hash['name'],
      :company => attr_hash['company'],
      :street1 => attr_hash['street1'],
      :city => attr_hash['city'],
      :state => attr_hash['state'],
      :phone => attr_hash['phone_number'],
      :zip => attr_hash['zip']
    )
  end

  def create_parcel(attr_hash)
    @parcel = EasyPost::Parcel.create(
      :length => attr_hash['length'].to_f,
      :width => attr_hash['width'].to_f,
      :height => attr_hash['height'].to_f,
      :weight => attr_hash['weight'].to_f
    )
  end

  def create_shipment
    @shipment = EasyPost::Shipment.create(
      :to_address => self.to_address,
      :from_address => self.from_address,
      :parcel => self.parcel
    )
  end

  # Retunrs the url of the shipping label
  def buy_shipment
    @shipment.buy(
      :rate => @shipment.lowest_rate(carriers = ['USPS'], services = ['First'])
    )
    @shipment.postage_label.label_url
  end
end