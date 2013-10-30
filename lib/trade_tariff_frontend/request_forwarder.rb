require 'uri'
require 'net/http'

module TradeTariffFrontend
  class RequestForwarder
    IGNORED_UPSTREAM_HEADERS = %w[status x-ua-compatible connection transfer-encoding]

    def initialize(opts = {})
      @host = URI.parse(opts.fetch(:host))
    end

    def host
      @host.host
    end

    def port
      @host.port
    end

    def call(env)
      rackreq = Rack::Request.new(env)

      case rackreq.request_method
      # The API is read-only
      when "GET", "HEAD"
        response = HTTParty.send(rackreq.request_method.downcase, request_url_for(rackreq), request_headers_for(env))

        Rack::Response.new(
          [response.body],
          response.code.to_i,
          Rack::Utils::HeaderHash.new(
            response.headers.
                     except(*IGNORED_UPSTREAM_HEADERS).
                     merge('X-Slimmer-Skip' => true)
          )
        ).finish
      else
        # "DELETE", "OPTIONS", "TRACE" "PUT", "POST"
        #
        # 405 METHOD NOT ALLOWED

        Rack::Response.new([], 405, {})
      end
    end

    private

    def request_url_for(rackreq)
      "http://#{host}:#{port}#{rackreq.env["PATH_INFO"]}"
    end

    def request_headers_for(env)
      headers = Rack::Utils::HeaderHash.new

      env.each { |key, value|
        if key =~ /HTTP_(.*)/
          headers[$1] = value
        end
      }
    end
  end
end
