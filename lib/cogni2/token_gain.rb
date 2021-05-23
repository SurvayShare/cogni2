# frozen_string_literal: true

require 'typhoeus'
require 'jwt'

module Cogni2
  module TokenGain
    # require [:domain] [:client_id] [:redirect_uri]
    OAUTH_PATH = '/oauth2/token'

    def gain_token(code)
      response = Typhoeus.post(oauth_url(self.options[:domain]),
        headers: {'Content-Type'=> 'application/x-www-form-urlencoded'},
        body: {
         grant_type: 'authorization_code', 
         client_id: self.options[:client_id],
         code: code,
         redirect_uri: self.options[:redirect_uri]
      })
      raise 'Invalid auth' if response.code > 300
  
      JSON.parse(response.body)
    end

    def oauth_url(domain)
      "#{domain}#{OAUTH_PATH}"
    end
  end
end