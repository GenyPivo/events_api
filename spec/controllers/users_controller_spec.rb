require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  let!(:model) { User }
  it_behaves_like 'record create' do
    let!(:user) do
      {
          user: {
              email: 'exx@sample.com',
              password: 'password'
          }
      }
    end
    let!(:params) { {query: user} }
  end
end
