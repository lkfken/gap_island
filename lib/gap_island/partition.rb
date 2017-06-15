module GapIsland
  class Partition
    attr_reader :group_elements

    def initialize(elements)

      hash = elements.inject(Hash.new) do |hsh, e|
        hsh[e.attribute] ||= []
        hsh[e.attribute] << e
        hsh
      end

      @group_elements = hash.map do |k, v|
        GroupElements.new(attribute: k, elements: v)
      end
    end

    def islands
      @group_elements.flat_map { |ge| ge.combined_elements }
    end

    def attributes
      @attributes ||= @group_elements.map { |group| group.attribute }
    end

    def count
      @group_elements.size
    end

    def key(attribute)
      @group_elements.find { |group| group.attribute == attribute }
    end

    alias_method :attribute, :key

    # def to_s
    #   @islands.map(&:to_s).join("\n")
    # end
  end
end