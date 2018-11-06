require 'rails_helper'

describe 'as a user' do
  it 'can add multiple addresses' do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    new_address = create(:address)

    visit new_address_path

    fill_in "address_name", with: new_address.name
    fill_in "address_street_address", with: new_address.street_address
    fill_in "address_city", with: new_address.city
    fill_in "address_state", with: new_address.state
    fill_in "address_zip", with: new_address.zip

    click_on 'Save Address'

    expect(current_path).to eq(user_path(@user))
  end
end
