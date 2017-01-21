RSpec.shared_context "shared oauth", :shared_context => :metadata do
  let!(:user) { create(:user) }
  let!(:token) { create(:oauth_token, resource_owner_id: user.id) }

  before do
    allow(controller).to receive(:doorkeeper_token) { token }
  end

  def response_data(response)
    JSON.parse(response.body)['data'].to_json
  end

end

RSpec.configure do |rspec|
  rspec.include_context "shared oauth", :include_shared => true
end
