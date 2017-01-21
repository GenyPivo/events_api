require 'rails_helper'

RSpec.describe Api::CommentsController, type: :controller do
  include_context "shared oauth"
  let!(:event) { create(:event, user_id: user.id)}
  let!(:comment) { create(:comment, event_id: event.id, user_id: user.id) }
  let!(:new_comment) do
    { message: Faker::Lorem.paragraph(1), event_id: event.id, id: event.id }
  end
  let!(:model) { Comment }

  describe "event comments index" do
    it_behaves_like "action response" do
      let!(:action) { :index }
      let!(:params) { { collection: event.comments, query: { event_id: event.id } } }
    end
  end

  describe "event comment create" do
    it_behaves_like 'record create' do
      let!(:action) { :create }
      let!(:params) { { query: new_comment } }
    end
  end

  describe "event comment update" do
    it_behaves_like 'record update' do
      let!(:params) { { query: new_comment, record_id: comment.id} }
    end
  end

  describe "event comment destroy" do
    it_behaves_like 'record destroy' do
      let!(:params) { { query: { event_id: event.id, id: comment.id } } }
    end
  end
end
