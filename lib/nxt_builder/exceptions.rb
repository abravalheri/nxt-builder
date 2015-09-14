module NxtBuilder
  class AlreadyDefinedMethod < StandardError
    def initialize(method)
      super("Cannot redefine method #{method}.")
    end
  end
end
