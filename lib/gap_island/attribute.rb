module GapIsland
  class Attribute
    attr_reader :content

    def initialize(content)
      @content = content
    end

    def to_s
      content.to_s
    end

    def eql?(attribute)
      self.class == attribute.class && content == attribute.content
    end

    def hash
      raise "#{content.class} must have :hash method in order to use it as a hash key or as Set" unless content.respond_to?(:hash)
      content.hash
    end

    alias_method :==, :eql?
  end
end