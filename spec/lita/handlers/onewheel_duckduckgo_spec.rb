require 'spec_helper'
# require 'onewheel-duckduckgo'

describe Lita::Handlers::OnewheelDuckDuckGo, lita_handler: true do

  before(:each) do
    mock_result_json = File.open('spec/fixtures/mock_result.json').read
    allow(RestClient).to receive(:get).and_return(JSON.parse mock_result_json)
  end

  it { is_expected.to route_command('duck something') }

  it 'does neat ducky things' do
    send_command 'duck yo'
    expect(replies.last).to include("DuckDuckGo Result: DuckDuckGo is an Internet search engine that emphasizes")
  end
end
