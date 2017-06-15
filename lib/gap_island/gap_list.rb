module GapIsland
  class GapList
    attr_reader :range, :partition
    NULL_ATTR = nil

    def initialize(range:, partition:)
      @range     = range
      @partition = partition
    end

    def gap_attribute
      @@gap_attribute ||= GapIsland::Attribute.new(NULL_ATTR)
    end

    def to_a
      inner_gaps = gather_inner_gaps(islands)
      outer_gaps = gather_outer_gaps(islands)
      elements   = [inner_gaps, outer_gaps].flatten.compact.sort
    end

    def islands
      combined_islands_no_attr
    end

    private

    def __islands
      @islands ||= partition.attributes.flat_map { |attribute| partition.key(attribute).combined_elements }
    end

    def islands_no_attr
      @islands_no_attr ||= __islands.map { |island| GapIsland::Element.new(attribute: gap_attribute, date_range: island.date_range) }
    end

    def partition_with_null_attr
      GapIsland::Partition.new(islands_no_attr).attribute(gap_attribute)
    end

    def combined_islands_no_attr
      @combined_islands_no_attr ||= partition_with_null_attr.combined_elements
    end

    def gather_outer_gaps(segments)
      return range if segments.empty?
      first_segment = segments[0]
      last_segment  = segments[-1]
      attribute     = first_segment.attribute
      [outer_left(attribute, first_segment), outer_right(attribute, last_segment)].compact
    end

    def outer_left(attribute, first_segment)
      return nil if range.nil?
      if range.first < first_segment.begin_date.prev_day
        GapIsland::Element.new(attribute: attribute, date_range: range.first..(first_segment.begin_date.prev_day))
      else
        nil
      end
    end

    def outer_right(attribute, last_segment)
      return nil if range.nil?
      if range.last > last_segment.end_date.next_day
        GapIsland::Element.new(attribute: attribute, date_range: (last_segment.end_date.next_day)..(range.last))
      else
        nil
      end
    end

    def gather_inner_gaps(segments)
      return nil if segments.size < 2
      if segments.size > 2
        remain_segments = segments[2..-1]
        gather_inner_gaps(remain_segments)
      else
        start_segment = segments[0]
        end_segment   = segments[1]
        gap_start     = start_segment.date_range.last.next_day
        gap_end       = end_segment.date_range.first.prev_day
        GapIsland::Element.new(attribute: gap_attribute, date_range: (gap_start)..(gap_end))
      end
    end
  end
end
