# frozen_string_literal: true

module Organ
  module AccessLevel
    GLOBAL = 1
    DEEP = 2
    LOCAL = 3
    BASIC = 4
    NONE = 5

    module_function

    def min(level1, level2)
      [level1, level2].min
    end
  end
end
