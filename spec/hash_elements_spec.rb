require 'rspec'
require_relative '../lib/gap_island'
require 'pp'

describe GapIsland::HashElements do
  let(:s1) { GapIsland::Element.new(:attribute => GapIsland::Attribute.new(nil), :date_range => Date.civil(2017, 1, 1)..Date.civil(2017, 4, 30)) }
  let(:s2) { GapIsland::Element.new(:attribute => GapIsland::Attribute.new(nil), :date_range => Date.civil(2017, 2, 1)..Date.civil(2017, 3, 31)) }
  let(:s3) { GapIsland::Element.new(:attribute => GapIsland::Attribute.new(nil), :date_range => Date.civil(2017, 8, 15)..Date.civil(2017, 10, 31)) }
  it '#keys' do
    pp hash_elements.attributes
  end
end