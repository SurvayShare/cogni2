# frozen_string_literal: true

require_relative "cogni2/version"

require 'cogni2/token_gain'

module Cogni2
  class Error < StandardError; end

  class Client
    include TokenGain

    attr_reader :options
    
    def initialize(**options)
      @options = options
    end

    def push_options(**options)
      @options.merge!(options)
      self
    end
  end
end
