# frozen_string_literal: true

module Cogni2
  module UserInfo
    USER_INFO_PATH = '/oauth2/userInfo'

    def fetch_user_info(access_token)
      response = Typhoeus.get(user_info_url,
                              headers: { 'Authorization' => authorization(access_token) })

      JSON.parse(response.body)
    end

    private

    def authorization(token)
      "Bearer #{token}"
    end

    def user_info_url
      "#{options[:domain]}#{USER_INFO_PATH}"
    end
  end
end
