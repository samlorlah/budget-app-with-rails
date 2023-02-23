require 'rails_helper'

RSpec.feature 'Transactions', type: :feature do
  before :each do
    @user = User.create(name: 'John Doe', email: 'test@email.com', password: '123456')
    @category = Group.create(author: @user, name: 'Soup',
                             icon: 'https://www.flaticon.com/svg/static/icons/svg/3144/3144456.svg')
    @transaction = Expense.create(author: @user, name: 'Food', amount: 10, groups: [@category])

    visit root_path
    click_link 'Login'

    within('#new_user') do
      fill_in 'Email', with: 'test@email.com'
      fill_in 'Password', with: '123456'
    end
    click_button 'Log in'
    visit group_expenses_path(@category)
  end

  it 'visits categories page' do
    expect(page).to have_content 'Soup\' Transactions'
  end

  it 'should have total transactions price' do
    expect(page).to have_content "Total: $ #{@transaction.amount}"
  end
end
