module GapIsland
  class Partition
    attr_reader :islands

    def initialize(elements)
      hash = elements.inject(Hash.new) do |hsh, e|
        hsh[e.attribute] ||= []
        hsh[e.attribute] << e
        hsh
      end

      @islands = hash.map do |k, v|
        GroupElements.new(attribute: k, elements: v)
      end
    end

    def attributes
      @attributes ||= @islands.map { |group| group.attribute }
    end

    def count
      @islands.size
    end

    def key(attribute)
      @islands.find { |group| group.attribute == attribute }
    end

    alias_method :attribute, :key

    def to_s
      @islands.map(&:to_s).join("\n")
    end
  end
end