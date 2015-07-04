require 'rails_helper'

feature 'user sees all shoes', %{
  As a user
  I want to see all the shoes
  so I know what I own
} do
  # Acceptance Criteria:
  # [x] I must be able to go to the root page to see all the shoes.
  # [x] If I am not signed in, I can see all the shoes in the database.
  # [x] If I am signed in, I can then see my shoes.

  let!(:shoe) { Shoe.create(brand: "Nike", model: "Air Force 1", color: "Black") }
  let!(:shoe2) { Shoe.create(brand: "Puma", model: "Trainers", color: "Pink") }
  let!(:user) { User.create(email: "dev@web.com", password: "12345678") }
  let!(:userShoe) { UserShoe.create(user_id: user.id, shoe_id: shoe.id) }

  context 'user is signed in' do
    before(:each) do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end

    scenario 'visits root index page' do
      visit root_path
      expect(page).to have_content(shoe.brand)
      expect(page).to have_content(shoe.model)
      expect(page).to have_content(shoe.color)
      expect(page).to_not have_content(shoe2.brand)
      expect(page).to_not have_content(shoe2.model)
      expect(page).to_not have_content(shoe2.color)
    end
  end

  context 'user is not signed in' do
    scenario 'visits root index page' do
      visit root_path
      expect(page).to have_content(shoe.brand)
      expect(page).to have_content(shoe.model)
      expect(page).to have_content(shoe.color)
      expect(page).to have_content(shoe2.brand)
      expect(page).to have_content(shoe2.model)
      expect(page).to have_content(shoe2.color)
    end
  end
end
