require 'rails_helper'

RSpec.describe 'Groups', type: :request do
  before :each do
    @user = User.create(name: 'John Doe', email: 'test@email.com', password: '123456')

    Group.create([
                   { author: @user, name: 'Entertainment',
                     icon: 'https://placeholderimage.com' },
                   { author: @user, name: 'Appliances', icon: 'https://placeholderimage.com' }
                 ])

    sign_in @user
    get groups_path
  end

  it 'assigns all categories to @groups' do
    expect(assigns(:groups)).to eq(@user.groups)
  end

  it 'is a success' do
    expect(response).to have_http_status(:ok)
  end

  it 'should get new if signed in' do
    get new_group_path
    expect(response).to have_http_status(:ok)
  end

  it 'should make a post with success message' do
    get new_group_path
    post groups_path,
         params: { group: { name: 'Music', icon: 'https://placeholderimage.com' } }

    get groups_path
    expect(response.body).to match 'Category was successfully created.'
  end

  it 'should redirect to new with status unprocessable_entity if name is nil' do
    get new_group_path
    post groups_path, params: { group: { name: nil, icon: 'https://placeholderimage.com' } }
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it "renders 'index' template" do
    expect(response).to render_template('index')
  end
end
