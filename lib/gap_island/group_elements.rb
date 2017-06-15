module GapIsland
  class GroupElements
    attr_reader :attribute, :elements

    def initialize(attribute: nil, elements: nil)
      @attribute = attribute
      @elements  = elements
      @elements  = elements.sort if elements && elements.size > 1
    end

    def empty?
      size.zero?
    end

    def size
      combined_elements.size
    end

    def [](index)
      combined_elements[index]
    end

    def combined_elements
      @combined_elements ||= __combined_elements__
    end

    def __combined_elements__(some_segments = elements)
      return some_segments if some_segments.size <= 1
      segments = GapIsland::Arithmetic.new.group(some_segments[0], some_segments[1])
      if some_segments.size > 2
        remain_segments = some_segments[2..-1]
        __combined_elements__([segments, remain_segments].flatten)
      else
        segments
      end
    end

    def to_s
      s = []
      s << attribute.to_s
      s << elements.map(&:to_s).join("\n")
      s.join("\n")
    end
  end
end