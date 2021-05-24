# frozen_string_literal: true

require_relative 'cogni2/version'

require 'typhoeus'
require 'cogni2/token_gain'
require 'cogni2/user_info'

module Cogni2
  class Error < StandardError; end

  class Client
    include TokenGain
    include UserInfo

    attr_reader :options

    def initialize(**options)
      @options = options
      puts options
    end

    def push_options(**options)
      @options.merge!(options)
      self
    end
  end
end
