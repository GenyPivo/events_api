RSpec.shared_examples 'successful request' do
  it 'returns http success' do
    get action, params[:query]
    expect(response.content_type).to eq 'application/json'
    expect(response).to have_http_status(:success)
  end
end

RSpec.shared_examples 'unsuccessful request' do
  it 'returns http client error' do
    get action, params[:query]
    expect(response.content_type).to eq 'application/json'
    expect(response).to have_http_status(params[:code])
  end
end

RSpec.shared_examples 'action response' do
  it_behaves_like 'successful request'

  it 'returns correct json' do
    get action, params[:query]
    expect(response_data(response)).to eq params[:collection].to_json
  end
end

RSpec.shared_examples 'record destroy' do
  let!(:action) { :destroy }

  it_behaves_like 'successful request'

  it 'decrease number of events' do
    expect { delete action, params[:query] }.to change(model, :count).by(-1)
  end
end

RSpec.shared_examples 'record create' do
  let!(:action) { :create }

  it_behaves_like 'successful request'

  it 'create new record' do
    expect { post action, params[:query] }.to change(model, :count).by(1)
  end
end

RSpec.shared_examples 'record update' do
  let!(:action) { :update }

  it_behaves_like 'successful request'

  it 'upate event successfully' do
    put action, params[:query]
    ev = model.find(params[:record_id])
    params[:query].each do |k, v|
      if !k.to_s.include? 'time'
        expect(ev.send(k)).to eq v
      else
        expect(DateTime.strptime(v.to_s, '%s')).to eq ev.send(k)
      end
    end
  end
end
