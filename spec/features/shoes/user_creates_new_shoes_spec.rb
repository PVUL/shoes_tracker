require 'rails_helper'

feature 'user creates new shoes', %{
  As a user
  I want to create new shoes
  so that I can add them to my collection
} do
  # Acceptance Criteria:
  # [ ] I must specify the brand, model, and color of the shoe.
  # [ ] I can optional create a nickname for the shoe.
  # [ ] If I enter all of the required information in the required formats, the
  #     shoes are recorded and I am presented with a notification of success.
  # [ ] If I do not specify all of the required information in the required
  #     formats, the shoes are not recorded and I am presented with errors.
  # [ ] Upon successfully creating new shoes, I am redirected back to the index
  #     of my shoes.
  # [ ] I must be logged in to create new shoes.

  #let! applies let to each scenario/context
  let(:user) { User.create(email: "dev@web.com", password: "12345678") }

  context 'user is signed in' do
    before(:each) do
      visit new_user_session_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      click_button 'Log in'
    end

    scenario 'specify required information' do
      visit new_user_shoe_path

      fill_in 'Model', with: 'Air Max 90'
      fill_in 'Brand', with: 'Nike'
      fill_in 'Color', with: 'Orange'

      click_button 'Submit'

      expect(page).to have_content('Successfully Added')
      expect(page).to have_content('Nike')
      expect(page).to have_content('Air Max 90')
      expect(page).to have_content('Orange')
    end
  end
end
