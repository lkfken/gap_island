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

    def to_hash
      @to_hash ||= begin
        @to_hash            = Hash.new
        @to_hash[attribute] = combined_elements
        @to_hash
      end
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
      remain_segments = some_segments[1..-1]
      combined_remain_segments = case
                                 when remain_segments.empty?
                                   []
                                 when remain_segments.size == 1
                                   GapIsland::Arithmetic.new.group(some_segments[0], remain_segments[0])
                                 when remain_segments.size > 1
                                   __combined_elements__(remain_segments)
                                 end

      front_segments           = GapIsland::Arithmetic.new.group(some_segments[0], combined_remain_segments[0])
      if combined_remain_segments.size > 1
        return front_segments.concat(combined_remain_segments[1..-1]).flatten
      else
        return front_segments
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