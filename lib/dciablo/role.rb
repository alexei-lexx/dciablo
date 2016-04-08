require 'delegate'

module Dciablo
  class Role < SimpleDelegator
    attr_reader :context

    def initialize(actor, context)
      super(actor)
      @context = context
    end
  end
end
