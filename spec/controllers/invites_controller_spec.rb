require 'rails_helper'

RSpec.describe InvitesController, type: :controller do
  include_context "shared oauth"
  let!(:invited_user) { create(:user, email: 'sample@sample.net') }
  let!(:invited_user2) { create(:user, email: 'sample2@sample.net') }
  let!(:event) { create(:event, user_id: user.id) }
  let!(:invite) do
    create(:invite, user_id: user.id, invited_user_id: invited_user.id, event_id: event.id)
  end
  let!(:new_invite) do
    { event_id: event.id, invited_user_id: invited_user2.id }
  end
  describe "show event invites" do
    it_behaves_like "action response" do
      let!(:action) { :index }
      let!(:params) { { collection: event.invites , query: { event_id: event.id } } }
    end
  end

  describe "event invite create" do
    it_behaves_like 'record create' do
      let!(:params) { { query: new_invite } }
    end
  end

  describe "event invite destroy" do
    it_behaves_like 'record destroy' do
      let!(:params) { { query: { event_id: event.id, id: invite.id } } }
    end
  end
end
