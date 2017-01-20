require 'rails_helper'

RSpec.describe Event, type: :model do

  let!(:event) { create(:event) }

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

  describe 'event time validation' do

    it 'validate event time correctly' do
      expect(Event.count).to eq 1
    end

    it 'raise validation error' do
      expect { create(:event, event_time: Date.today - 2.days) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

end
