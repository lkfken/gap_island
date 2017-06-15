module GapIsland
  class Attribute
    attr_reader :content

    def initialize(content)
      raise "#{content.class} must have :hash method" unless content.respond_to?(:hash)
      @content = content
    end

    def to_s
      content.to_s
    end

    def eql?(attribute)
      self.class == attribute.class && content == attribute.content
    end

    def hash
      content.hash
    end

    alias_method :==, :eql?
  end
end