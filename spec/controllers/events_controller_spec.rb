require 'rails_helper'

RSpec.describe Api::EventsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:token) { create(:oauth_token, resource_owner_id: user.id) }
  let!(:event) { create(:event, user_id: user.id)}

  before do
    allow(controller).to receive(:doorkeeper_token) { token }
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    it "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end

end
