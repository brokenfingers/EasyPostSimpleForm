class ShipmentsController < ApplicationController
  def index
  end

  def create
    @shipment = Shipment.create_shipment(params[:shipment], params[:from_address], params[:to_address])
    redirect_to root_path, :alert => 'Shipment Failed to be Created' and return if @shipment.nil?
    redirect_to shipment_path(@shipment.id)
  end

  def show
    @shipment = Shipment.find_by_id(params[:id])
  end

end