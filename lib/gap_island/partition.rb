module GapIsland
  class Partition
    def initialize(elements)
      hash    = elements.inject(Hash.new) do |hsh, e|
        hsh[e.attribute] ||= []
        hsh[e.attribute] << e
        hsh
      end
      @groups = hash.map do |k, v|
        GroupElements.new(attribute: k, elements: v)
      end
    end

    def count
      @groups.size
    end

    def key(attribute)
      @groups.find { |group| group.attribute == attribute }
    end

    def to_s
      @groups.map(&:to_s).join("\n")
    end
  end
end