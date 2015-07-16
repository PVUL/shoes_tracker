require 'rails_helper'

feature 'user creates new shoes', %{
  As a user
  I want to create new shoes
  so that I can add them to my collection
} do
  # Acceptance Criteria:
  # [x] I must specify the brand, model, and color of the shoe.
  # [x] If I enter all of the required information in the required formats, the
  #     shoes are recorded and I am presented with a notification of success.
  # [x] If I do not specify all of the required information in the required
  #     formats, the shoes are not recorded and I am presented with errors.
  # [x] Upon successfully creating new shoes, I am redirected back to the index
  #     of my shoes.
  # [x] I must be logged in to create new shoes.
  # [x] User can optionally upload an image of their shoes.

  let!(:user) { User.create(email: "dev@web.com", password: "12345678") }

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

    scenario 'specify required information and upload an image' do
      visit new_user_shoe_path

      fill_in 'Model', with: 'Air Max 90'
      fill_in 'Brand', with: 'Nike'
      fill_in 'Color', with: 'Orange'
      attach_file('user_shoe[image]',
        File.absolute_path('./spec/support/upload/image_upload.jpg'))
      click_button 'Submit'

      page.should have_selector("img[src$='image_upload.jpg']")
      expect(page).to have_content('Successfully Added')
      expect(page).to have_content('Nike')
      expect(page).to have_content('Air Max 90')
      expect(page).to have_content('Orange')
    end

    scenario 'specify required information with invalid information' do
      visit new_user_shoe_path

      fill_in 'Model', with: ''
      fill_in 'Brand', with: ''
      fill_in 'Color', with: ''
      click_button 'Submit'

      expect(page).to have_content("Brand can't be blank")
      expect(page).to have_content("Model can't be blank")
      expect(page).to have_content("Color can't be blank")
    end
  end

  context 'user is not signed in' do
    scenario 'attempts to add new shoes' do
      visit new_user_shoe_path
      expect(page).to have_content("Must be signed in to add shoes")
    end
  end
end
