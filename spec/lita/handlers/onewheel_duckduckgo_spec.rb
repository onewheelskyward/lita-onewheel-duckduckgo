require 'spec_helper'
# require 'onewheel-duckduckgo'

describe Lita::Handlers::OnewheelDuckDuckGo, lita_handler: true do

  before(:each) do
  end

  def mock(file)
    mock_result_json = File.open("spec/fixtures/#{file}.json").read
    allow(RestClient).to receive(:get).and_return( mock_result_json)
  end

  it { is_expected.to route_command('duck something') }
  it { is_expected.to route_command('quack something') }
  it { is_expected.to route_command('ddg something') }

  it 'does neat ducky things' do
    mock('mock_result')
    send_command 'duck yo'
    expect(replies.last).to include('DuckDuckGo is an Internet search engine that emphasizes')
  end

  it 'uses the url unless the abstract exists' do
    mock('mock_no_abstract')
    send_command 'duck yo'
    expect(replies.last).to include('https://en.wikipedia.org/wiki/Duck_(disambiguation)')
  end

  it 'checks for go' do
    mock('mock_go')
    send_command 'duck go'
    expect(replies.last).to include('https://en.wikipedia.org/wiki/Go')
  end
end
