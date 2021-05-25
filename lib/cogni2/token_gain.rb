# frozen_string_literal: true

require 'jwt'

module Cogni2
  module TokenGain
    # require [:domain] [:client_id] [:redirect_uri]
    OAUTH_PATH = '/oauth2/token'

    def gain_token(code)
      response = Typhoeus.post(oauth_url,
                               headers: { 'Content-Type' => 'application/x-www-form-urlencoded' },
                               body: {
                                 grant_type: 'authorization_code',
                                 client_id: options[:client_id],
                                 code: code,
                                 redirect_uri: options[:redirect_uri]
                               })

      JSON.parse(response.body)
    end

    def request_new_token(refresh_token)
      response = Typhoeus.post(oauth_url,
                               headers: { 'Content-Type' => 'application/x-www-form-urlencoded' },
                               body: {
                                 grant_type: 'refresh_token',
                                 client_id: options[:client_id],
                                 refresh_token: refresh_token
                               })

      JSON.parse(response.body)
    end

    private

    def oauth_url
      "#{options[:domain]}#{OAUTH_PATH}"
    end
  end
end
