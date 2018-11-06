class AddressesController < ApplicationController

  def new
    @address = Address.new
  end

  def create
    @address = current_user.addresses.create(address_params)
    @address.save
    redirect_to user_path(current_user)
  end

  private
    def address_params
      params.require(:address).permit(:name, :street_address, :city, :state, :zip)
    end
end
