class String
  def underscore
    self.gsub(/::/, '/')
        .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
        .gsub(/([a-z\d])([A-Z])/,'\1_\2')
        .tr("-", "_")
        .downcase
  end
end

module Web3
  module Eth
    class Contract
      class Instance
        def initialize(instance)
          @instance = instance
          @instance.JS[:abi].map do |elem|
            if `elem.type` == "function" then
              name = `elem.name`
              define_singleton_method(name.underscore) do |*args, &block|
                @instance.JS[name].call(*args, -> (error, result) do
                  block.call(error, result)
                end)
              end
            elsif `elem.type` == "Event" then
              # Do something in the future with Events.
            end
          end
        end
      end
    end
  end
end
