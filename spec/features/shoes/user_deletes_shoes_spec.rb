require 'rails_helper'

feature 'user deletes shoes', %{
  As a user
  I want to delete my shoes
  so that I can delete them from my collection
} do
  # Acceptance Criteria:
  # [x] I must be logged in as a user to see my shoes.
  # [x] If I click on the delete link, my shoes will be deleted from my shoes
  #     index page
  # [x] Upon successfully deleting of shoes, I am redirected back to the index
  #     of my shoes.

  let!(:user) { User.create(email: "dev@web.com", password: "12345678") }
  let!(:shoe) { Shoe.create(brand: "Nike", model: "AF 1", color: "Black") }
  let!(:userShoe) { UserShoe.create(user_id: user.id, shoe_id: shoe.id) }

  context 'user is signed in' do
    before(:each) do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end

    scenario 'specify required information' do
      visit shoes_path
      click_link 'delete'

      expect(page).to have_content('Successfully Deleted')
    end
  end
end
