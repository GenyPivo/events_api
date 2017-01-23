require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:comment) { build(:comment) }

  it "is valid with valid attributes" do
    expect(comment).to be_valid
  end

  context 'valid with mime in list' do
    before { comment.document = File.new(Rails.root + 'spec/fixtures/images/ruby.png')}
    it "is valid with image" do
      expect(comment).to be_valid
    end
  end

  context 'not valid with other mime' do
    before { comment.document = File.new(Rails.root + 'spec/fixtures/documents/file.js') }
    it "is invalid with javascript" do
      expect(comment).to be_invalid
    end
  end

  it 'associations' do
    expect(subject).to belong_to(:event)
    expect(subject).to belong_to(:user)
  end

  it 'validations' do
    should validate_presence_of(:message)
    should validate_length_of(:message).is_at_most(200)

  end

end
