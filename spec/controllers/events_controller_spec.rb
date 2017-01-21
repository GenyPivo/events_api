require 'rails_helper'

RSpec.describe Api::EventsController, type: :controller do
  include_context "shared oauth"

  let!(:event) { create(:event, user_id: user.id)}
  let!(:second_user) { create(:user, email: 'sample@sample.com') }
  let!(:second_user_event) { create(:event, user_id: second_user.id) }
  let!(:new_event_hash) do
    {
        place: Faker::Address.full_address,
        purpose: Faker::Lorem.paragraph(2),
        event_time: (Date.today + 2.days).to_time.to_i
    }
  end

  describe "event index" do
    it "returns http success" do
      get :index
      expect(response.content_type).to eq 'application/json'
      expect(response).to have_http_status(200)
    end

    it 'returns correct json' do
      get :index
      expect(response_data(response)).to eq user.events.to_json
    end
  end

  describe "event show" do
    it "returns http success" do
      get :show, id: event.id
      expect(response.content_type).to eq 'application/json'
      expect(response).to have_http_status(200)
    end

    it "returns correct json" do
      get :show, id: event.id
      expect(response_data(response)).to eq user.events.find(event.id).to_json
    end

    it "returns forbidden" do
      get :show, id: second_user_event.id
      expect(response.content_type).to eq 'application/json'
      expect(response).to have_http_status(403)
    end

    it "returns permission denied" do
      get :show, id: second_user_event.id
      expect(response_data(response, 'message')).to eq 'Permission denied'.to_json
    end

  end

  describe "event create" do
    context 'record will be created if correct data' do
      it "returns http success" do
        post :create, new_event_hash
        expect(response.content_type).to eq 'application/json'
        expect(response).to have_http_status(201)
        expect(Event.count).to eq 2
      end
    end

    context 'record will be not created if incorrect data' do
      before do
        new_event_hash[:event_time] = (Date.today - 5.days).to_time.to_i
      end

      it "returns http unprocessable entity" do
        post :create, new_event_hash
        expect(response.content_type).to eq 'application/json'
        expect(response).to have_http_status(422)
        expect(Event.count).to eq 1
      end
    end

  end

  describe "event update" do
    before do
      new_event_hash[:id] = event.id
    end
    it "returns http success" do
      get :update, new_event_hash
      expect(response.content_type).to eq 'application/json'
      expect(response).to have_http_status(200)
      expect(Event.find(event.id).purpose).to eq new_event_hash[:purpose]
    end
  end

  describe "event destroy" do
    let!(:foreign_user) { create(:user, email: Faker::Internet.email) }
    let!(:foreign_event) { create(:event, user_id: foreign_user.id) }

    it "user can delete own events" do
      get :destroy, { id: event.id }
      expect(response.content_type).to eq 'application/json'
      expect(response).to have_http_status(204)
      expect(Event.count).to eq 1
    end

    it "user cant delete foreign events" do
      get :destroy, { id: foreign_event.id }
      expect(response.content_type).to eq 'application/json'
      expect(response).to have_http_status(404)
      expect(Event.count).to eq 2
    end

  end
end
