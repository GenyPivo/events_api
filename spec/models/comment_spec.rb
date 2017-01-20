require 'rails_helper'

RSpec.describe Comment, type: :model do

  it "is valid with valid attributes" do
    expect(build(:comment)).to be_valid
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
