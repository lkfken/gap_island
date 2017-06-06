class GroupElements
  attr_reader :attribute, :elements

  def initialize(attribute: nil, elements: nil)
    @attribute = attribute
    @elements  = elements.sort
  end

  def combined_elements(some_elements = elements)
    return some_elements if some_elements.size == 1
    elements = GapIsland::Arithmetic.new.group(some_elements[0], some_elements[1])
    if some_elements.size > 2
      remain_elements = some_elements[2..-1]
      combined_elements([elements, remain_elements].flatten)
    else
      elements
    end
  end

  def to_s
    s = []
    s << attribute.to_s
    s << elements.map(&:to_s).join("\n")
    s.join("\n")
  end
end