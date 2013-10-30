require 'spec_helper'

describe TradeTariffFrontend::RequestForwarder do
  let(:app)          { ->(env) { [200, env, "app"] } }
  let(:host)         { 'http://tariff-api.example.com' }
  let(:request_path) { '/sections/1' }

  let(:response_body) { "example" }

  let :middleware do
    described_class.new(host: host)
  end

  around do |example|
    # These specs use WebMock
    VCR.turned_off do
      example.yield
    end
  end

  it 'forwards response from upstream backend host for GETs' do
    stub_request(:get, "#{host}#{request_path}").to_return(
      status: 200,
      body: response_body,
      headers: { 'Content-Length' => response_body.size }
    )

    status, env, body = middleware.call env_for(request_path)

    expect(body.body).to include response_body
  end

  it 'forwards response from upstream backend host for HEADs' do
    stub_request(:head, "#{host}#{request_path}").to_return(
      status: 200,
      body: '',
      headers: { 'Content-Length' => 0 }
    )

    status, env, body = middleware.call env_for(request_path, method: :head)

    expect(status).to eq 200
    expect(body.body).to eq [""]
  end

  it 'forwards response status code from upstream backend host' do
    stub_request(:get, "#{host}#{request_path}").to_return(
      status: 404,
      body: 'Not Found',
      headers: { 'Content-Length' => 'Not Found'.size }
    )

    status, env, body = middleware.call env_for(request_path)

    expect(status).to eq 404
  end

  it 'forwards allowed headers from upstream backend host' do
    stub_request(:get, "#{host}#{request_path}").to_return(
      status: 200,
      body: response_body,
      headers: {
        'Content-Length' => response_body.size,
        'Content-Type' => 'text/html'
      }
    )

    status, env, body = middleware.call env_for(request_path)

    expect(env['Content-Type']).to eq 'text/html'
  end

  it 'does not forward non-allowed headers from upstream backend host' do
    stub_request(:get, "#{host}#{request_path}").to_return(
      status: 200,
      body: response_body,
      headers: {
        'Content-Length' => response_body.size,
        'X-UA-Compatible' => 'IE=9'
      }
    )

    status, env, body = middleware.call env_for(request_path)

    expect(env['X-UA-Compatible']).to be_blank
  end

  it 'only accepts GET requests' do
    status, env, body = middleware.call env_for(request_path, method: :post)

    expect(status).to eq 405 # METHOD NOT ALLOWED
    expect(body).to be_blank
  end

  def env_for(url, opts = {})
    Rack::MockRequest.env_for(url, opts)
  end
end
