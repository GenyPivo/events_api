require 'rails_helper'

RSpec.describe Invite, type: :model do

  it "is valid with valid attributes" do
    expect(build(:invite)).to be_valid
  end

  it 'associations' do
    expect(subject).to belong_to(:user)
    expect(subject).to belong_to(:event)
  end

end
