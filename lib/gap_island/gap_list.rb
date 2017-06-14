module GapIsland
  class GapList
    attr_reader :range, :partition
    NULL_ATTR = nil

    def initialize(range:, partition:)
      @range     = range
      @partition = partition
    end

    def to_a
      inner_gaps = gather_inner_gaps(combined_islands_no_attr)
      outer_gaps = gather_outer_gaps(combined_islands_no_attr)
      [inner_gaps, outer_gaps].flatten.compact.sort
    end

    private

    def islands
      partition.attributes.flat_map { |attribute| partition.key(attribute).combined_elements }
    end

    def islands_no_attr
      islands.map { |island| Element.new(attribute: NULL_ATTR, date_range: island.date_range) }
    end

    def combined_islands_no_attr
      @combined_islands_no_attr ||= GapIsland::Partition.new(islands_no_attr).attribute(NULL_ATTR).combined_elements
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
        Element.new(attribute: attribute, date_range: range.first..(first_segment.begin_date.prev_day))
      else
        nil
      end
    end

    def outer_right(attribute, last_segment)
      return nil if range.nil?
      if range.last > last_segment.end_date.next_day
        Element.new(attribute: attribute, date_range: (last_segment.end_date.next_day)..(range.last))
      else
        nil
      end
    end

    def gather_inner_gaps(segments)
      return nil if segments.size < 2
      if segments.size > 2
        remain_segments = segments[2..-1]
        gather_gaps(remain_segments)
      else
        start_segment = segments[0]
        end_segment   = segments[1]
        gap_start     = start_segment.date_range.last.next_day
        gap_end       = end_segment.date_range.first.prev_day
        Element.new(attribute: start_segment.attribute, date_range: (gap_start)..(gap_end))
      end
    end
  end
end
