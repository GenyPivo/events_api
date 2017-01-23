require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:user)).to be_valid
  end

  it 'associations' do
    expect(subject).to have_many(:comments)
    expect(subject).to have_many(:events)
    expect(subject).to have_many(:invites)
  end
end
