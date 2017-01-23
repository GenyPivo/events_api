require 'rails_helper'

RSpec.describe Api::CommentsController, type: :controller do
  include_context 'shared oauth'
  let!(:event) { create(:event, user_id: user.id) }
  let!(:comment) { create(:comment, event_id: event.id, user_id: user.id) }
  let!(:new_comment) do
    { message: Faker::Lorem.paragraph(1), event_id: event.id, id: comment.id }
  end
  let!(:model) { Comment }

  describe 'record create' do
    let!(:params) { { query: new_comment } }
    it 'create comment with attach' do
      new_comment[:document] = fixture_file_upload('images/ruby.png')
      post :create, new_comment
      expect(IO.read(File.new(Comment.last.document.path))).to eq IO.read(new_comment[:document])
    end
  end

  describe 'event comment update' do
    it_behaves_like 'record update' do
      let!(:params) { { query: new_comment, record_id: comment.id } }
    end
  end

  describe 'event comment destroy' do
    it_behaves_like 'record destroy' do
      let!(:params) { { query: { event_id: event.id, id: comment.id } } }
    end
  end
end
