class AddressesController < ApplicationController

  def new
    @address = Address.new
  end

  def create
    @address = current_user.addresses.create(address_params)
    @address.save
    set_default_address(@address)
    redirect_to profile_path
  end

  def edit
    @address = current_user.addresses.find(params[:id])
  end

  def update
    @address = current_user.addresses.find(params[:id])
    @address.update(address_params)
    set_default_address(@address)
    redirect_to profile_path
  end

  def index
    @addresses = current_user.addresses.where(active: true)
  end

  private
    def address_params
      params.require(:address).permit(:name, :street_address, :city, :state, :zip, :active)
    end

    def set_default_address(address)
      if params[:default] == '1'
        current_user.default_address_id = address.id
        current_user.save
      end
    end
end
