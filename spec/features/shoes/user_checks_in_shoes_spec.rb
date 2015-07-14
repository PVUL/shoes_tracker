require 'rails_helper'

feature 'user checks in shoes', %{
  As a user
  I want to check in my shoes
  so I can track when they have been worn
} do
  # Acceptance Criteria:
  # [x] I must be signed in to see my list of shoes.
  # [x] I can check in a specfic shoe by clicking a link next to the shoe.
  # [x] After I check in the shoe, the last check in date/time gets updated.
  # [ ] I can only check in one shoe per day.

  let!(:shoe) { Shoe.create(brand: "Nike", model: "AF 1", color: "Black") }
  let!(:user) { User.create(email: "dev@web.com", password: "12345678") }
  let!(:userShoe) { UserShoe.create(user: user, shoe: shoe) }
  let!(:current_date) { Time.now.strftime("%m/%d/%y") }

  context 'user is signed in' do
    before(:each) do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end
    scenario 'user checks in shoe' do
      visit root_path
      click_link 'check in'

      expect(page).to have_content('Successfully Checked In')
      expect(page).to have_content(current_date)
    end
  end
end
