require 'rails_helper'

RSpec.describe Api::CommentsController, type: :controller do
  include_context "shared oauth"
  let!(:event) { create(:event, user_id: user.id)}
  let!(:comment) { create(:comment, event_id: event.id, user_id: user.id) }

  describe "event comments index" do
    it_behaves_like "controller index" do
      let!(:action) { :index }
      let!(:collection) { event.comments }
      let!(:query) { { event_id: event.id } }
    end
  end

  describe "event comment create" do
    it "returns http success" do
      get :create, event_id: event.id
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
