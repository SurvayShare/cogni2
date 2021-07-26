# frozen_string_literal: true

module Cogni2
  module UserInfo
    USER_INFO_PATH = '/oauth2/userInfo'

    def fetch_user_info(access_token)
      response = reuqest(user_info_url, :GET, authorize_header(access_token))
      JSON.parse(response.body.to_s)
    end

    private

    def user_info_url
      "#{options[:domain]}#{USER_INFO_PATH}"
    end
  end
end
