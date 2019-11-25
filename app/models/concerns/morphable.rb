# frozen_string_literal: true
module Morphable

    private

    def morph(klass, &block)
      becomes!(klass).tap { |object| object.save! }
    end
end