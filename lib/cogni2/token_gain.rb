# frozen_string_literal: true

require 'jwt'

module Cogni2
  module TokenGain
    # require [:domain] [:client_id] [:redirect_uri]
    OAUTH_PATH = '/oauth2/token'

    def gain_token(code)
      response = reuqest(oauth_url, :POST,
                         { 'Content-Type' => 'application/x-www-form-urlencoded' },
                         body: {
                           grant_type: 'authorization_code',
                           client_id: options[:client_id],
                           code: code,
                           redirect_uri: options[:redirect_uri]
                         })
      JSON.parse(response.body.to_s)
    end

    def request_new_token(refresh_token)
      response = reuqest(oauth_url,
                         { 'Content-Type' => 'application/x-www-form-urlencoded' },
                         body: {
                           grant_type: 'refresh_token',
                           client_id: options[:client_id],
                           refresh_token: refresh_token
                         })

      JSON.parse(response.body.to_s)
    end

    private

    def oauth_url
      "#{options[:domain]}#{OAUTH_PATH}"
    end
  end
end
