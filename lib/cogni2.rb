# frozen_string_literal: true

require_relative 'cogni2/version'

require 'typhoeus'
require 'cogni2/token_gain'
require 'cogni2/user_info'

module Cogni2
  class Error < StandardError; end

  class ConfigurationError < Error; end

  class CodeError < Error; end

  class Client
    include TokenGain
    include UserInfo

    attr_reader :options

    def initialize(**options)
      @options = {}
      push_options(options)
    end

    def push_options(**options)
      lacked_keys = %i[domain client_id redirect_uri] - options.keys
      raise ConfigurationError, "#{lacked_keys.join(', ')} are missing in configratuion" if lacked_keys.any?

      @options.merge!(options)
      self
    end

    private

    def reuqest(url, method, headers = {}, **data)
      request = Typhoeus::Request.new(
        url,
        method: method.to_sym,
        body: data[:body],
        params: data[:params],
        headers: { 'User-Agent': "Cogni2/#{VERSION}" }.merge(headers)
      )
      handle_response(request.run)
    end

    def handle_response(response)
      return response if response.success?

      case response.code
      when 400
        raise CodeError, 'You do not have sufficient access to perform this action.'
      when 500
        raise CodeError, 'The request processing has failed because of an unknown error, exception or failure.'
      when 403
        raise CodeError, 'The request must contain either a valid (registered) AWS access key ID or X.509 certificate.'
      when 503
        raise CodeError, 'The request has failed due to a temporary failure of the server.'
      else
        raise CodeError, "Unknown response code #{response.code}"
      end
    end

    def authorization(token)
      "Bearer #{token}"
    end

    def authorize_header(access_token)
      { 'Authorization' => authorization(access_token) }
    end
  end
end
