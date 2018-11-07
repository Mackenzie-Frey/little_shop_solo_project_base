require 'rails_helper'

describe 'as a user' do
  before(:each) do
    @user = create(:user)
    @address_1 = create(:address, user: @user)
    @user.default_address_id = @address_1.id
  end

  it 'can add a new address' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    new_address = create(:address)

    visit new_address_path

    fill_in "address_name", with: new_address.name
    fill_in "address_street_address", with: new_address.street_address
    fill_in "address_city", with: new_address.city
    fill_in "address_state", with: new_address.state
    fill_in "address_zip", with: new_address.zip

    click_on 'Save Address'

    expect(current_path).to eq(profile_path)
    expect(page).to have_content(new_address.name)
    expect(page).to have_content(new_address.street_address)
    expect(page).to have_content(new_address.city)
    expect(page).to have_content(new_address.state)
    expect(page).to have_content(new_address.zip)
  end

  it 'can change default address' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    address = create(:address)

    visit new_address_path

    fill_in "address_name", with: address.name
    fill_in "address_street_address", with: address.street_address
    fill_in "address_city", with: address.city
    fill_in "address_state", with: address.state
    fill_in "address_zip", with: address.zip
    check('default')
    click_on 'Save Address'

    expect(current_path).to eq(profile_path)
    expect(@user.default_address).to eq(address)
  end

  it 'can change an address' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit profile_path
    click_button('edit')

    expect(current_path).to eq(edit_address_path(@address_1))

    address_2 = create(:address)

    fill_in :address_name, with: address_2.name
    fill_in :address_street_address, with: address_2.street_address
    fill_in :address_city, with: address_2.city
    fill_in :address_state, with: address_2.state
    fill_in :address_zip, with: address_2.zip

    click_button('Save Address')

    expect(current_path).to eq(profile_path)
    expect(page).to have_content(address_2.name)
    expect(page).to have_content(address_2.street_address)
    expect(page).to have_content(address_2.city)
    expect(page).to have_content(address_2.state)
    expect(page).to have_content(address_2.zip)
  end
end
