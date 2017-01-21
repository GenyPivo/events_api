require 'rails_helper'
RSpec.describe Api::EventsController, type: :controller do
  include_context "shared oauth"

  let!(:event) { create(:event, user_id: user.id)}
  let!(:second_user) { create(:user, email: 'sample@sample.com') }
  let!(:second_user_event) { create(:event, user_id: second_user.id) }
  let!(:model) { Event }
  let!(:new_event_hash) do
    {
        place: Faker::Address.full_address,
        purpose: Faker::Lorem.paragraph(2),
        event_time: (Date.today + 2.days).to_time.to_i
    }
  end

  describe "event index" do
    it_behaves_like "action response" do
      let!(:action) { :index }
      let(:collection) { user.events }
      let!(:query) { {} }
    end
  end

  describe "event show" do
    it_behaves_like 'action response' do
      let!(:action) { :show }
      let!(:collection) { user.events.find(event.id) }
      let!(:query) { { id: event.id} }
    end

    it_behaves_like 'unsuccessful request' do
      let!(:action) { :destroy }
      let!(:query) { { id: second_user_event.id } }
      let!(:code) { 404 }
    end

    it "returns permission denied json" do
      get :show, id: second_user_event.id
      expect(response_data(response, 'message')).to eq 'Permission denied'.to_json
    end

  end

  describe "event create" do
    context 'record will be created if correct data' do
      it_behaves_like 'record create' do
        let!(:action) { :create }
        let!(:query) { new_event_hash }
      end
    end

    context 'record will be not created if incorrect data' do
      before do
        new_event_hash[:event_time] = (Date.today - 5.days).to_time.to_i
      end

      it_behaves_like 'unsuccessful request' do
        let!(:action) { :create }
        let!(:query) { new_event_hash }
        let!(:code) { 422 }
      end

      it "events count will have no changes" do
        expect { post :create, new_event_hash }.to change(Event, :count).by(0)
      end
    end

  end

  describe "event update" do
    before do
      new_event_hash[:id] = event.id
    end
    it_behaves_like 'successful request' do
      let!(:action) { :update }
      let!(:query) { new_event_hash }
    end

    it "upate event successfully" do
      put :update, new_event_hash
      expect(Event.find(event.id).purpose).to eq new_event_hash[:purpose]
    end
  end

  describe "event destroy" do
    let!(:foreign_user) { create(:user, email: Faker::Internet.email) }
    let!(:foreign_event) { create(:event, user_id: foreign_user.id) }

    it_behaves_like 'record destroy' do
      let!(:action) { :destroy }
      let!(:query) { { id: event.id } }
    end

    it_behaves_like 'unsuccessful request' do
      let!(:action) { :destroy }
      let!(:query) { { id: foreign_event.id } }
      let!(:code) { 404 }
    end

    it 'will not change number of events ' do
      expect { delete :destroy,  id: foreign_event.id }.to change(Event, :count).by(0)
    end

  end
end
