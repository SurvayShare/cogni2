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

    private

    def oauth_url
      "#{options[:domain]}#{OAUTH_PATH}"
    end
  end
end
