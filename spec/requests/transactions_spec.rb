require 'rails_helper'

RSpec.describe 'Expenses', type: :request do
  before :each do
    @user = User.create(name: 'Delvis', email: 'delvis23@gmail.com', password: '1223454')
    @category = Group.create(author: @user, name: 'Movies')
    Expense.create([
                     { author: @user, name: 'The Land of the dead', amount: 15, groups: [@category] },
                     { author: @user, name: 'Black Panther', amount: 20, groups: [@category] }
                   ])

    sign_in @user
    get group_expenses_path(@category)
  end

  it 'assigns all expenses to @expenses' do
    expect(assigns(:expenses)).to eq(@user.expenses.order(created_at: :desc))
  end

  it 'is a success' do
    expect(response).to have_http_status(:ok)
  end

  it 'should get new if signed in' do
    get new_group_expense_path(@category)
    expect(response).to have_http_status(:ok)
  end

  it 'should make a post with success message' do
    get new_group_expense_path(@category)
    post group_expenses_path(@category), params: { expense: { name: 'Avengers: Endgame', amount: 10.99 } }

    get group_expenses_path(@category)
    expect(response.body).to match 'Transaction was successfully created.'
  end

  it 'should redirect to new with status unprocessable_entity if name is nil' do
    get new_group_expense_path(@category)
    post group_expenses_path(@category), params: { expense: { name: nil, amount: 10.99 } }
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it "renders 'index' template" do
    expect(response).to render_template('index')
  end
end
