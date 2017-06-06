require 'yaml'
module GapIsland
  class Attribute
    attr_reader :content

    def initialize(content)
      raise "#{content.class} must have :to_s method" unless content.respond_to?(:to_s)
      @content = content.to_s
    end

    def to_s
      content
    end

    def ==(attribute)
      content == attribute.content
    end
  end
end