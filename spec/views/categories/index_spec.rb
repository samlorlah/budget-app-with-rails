require 'rails_helper'

RSpec.feature 'Categories', type: :feature do
  before :each do
    @user = User.create(name: 'John Doe', email: 'test@email.com', password: '123456')
    @category = Group.create(author: @user, name: 'Food',
                             icon: 'https://placeholderimage.com')

    visit root_path
    click_link 'Login'

    within('#new_user') do
      fill_in 'Email', with: 'test@email.com'
      fill_in 'Password', with: '123456'
    end
    click_button 'Log in'
  end

  it 'visits categories page' do
    expect(current_path).to match groups_path
    expect(page).to have_content 'Food'
  end

  it 'redirects to transactions page of the category' do
    within("#group_#{@category.id}") do
      click_on @category.name
    end
    expect(current_path).to match group_expenses_path(@category)
  end
end