require_relative "gap_island/version"
require_relative 'gap_island/attribute'
require_relative 'gap_island/element'
require_relative 'gap_island/group_elements'
require_relative 'gap_island/partition'
require_relative 'gap_island/gap_list'

module GapIsland
  class DifferentAttrError < StandardError

  end

  class Arithmetic
    def group(e1, e2)
      raise GapIsland::DifferentAttrError if !e1.same_attribute?(e2)
      list = (e1.dates | e2.dates).sort
      prev = list[0]
      list.slice_before { |date| prev, prev2 = date, prev; prev2.next_day != date
      }.map { |es| es.length < 2 ? es.first..es.first : es.first..es.last
      }.map { |date_range| Element.new(attribute: e1.attribute, date_range: date_range)
      }
    end
  end
end
