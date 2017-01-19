require 'rails_helper'

RSpec.describe Event, type: :model do

  it "is valid with valid attributes" do
    expect(build(:event)).to be_valid
  end

  it 'associations' do
    expect(subject).to have_many(:comments)
    expect(subject).to have_many(:invites)
  end

  it 'validations' do
    should validate_presence_of(:place)
    should validate_presence_of(:purpose)
    should validate_presence_of(:event_time)
    should validate_length_of(:purpose).is_at_most(300)
  end

end
