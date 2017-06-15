require 'rspec'
require_relative '../lib/gap_island'


describe GapIsland::GroupElements do
  context 'example #1' do
    let(:attr) { GapIsland::Attribute.new(nil) }
    let(:s1) { GapIsland::Element.new(:attribute => attr, :date_range => Date.civil(2017, 1, 1)..Date.civil(2017, 4, 30)) }
    let(:s2) { GapIsland::Element.new(:attribute => attr, :date_range => Date.civil(2017, 2, 1)..Date.civil(2017, 3, 31)) }
    let(:s3) { GapIsland::Element.new(:attribute => attr, :date_range => Date.civil(2017, 8, 15)..Date.civil(2017, 10, 31)) }
    let(:e1) { GapIsland::Element.new(:attribute => attr, :date_range => Date.civil(2017, 1, 1)..Date.civil(2017, 1, 31)) }
    let(:e2) { GapIsland::Element.new(:attribute => attr, :date_range => Date.civil(2017, 2, 1)..Date.civil(2017, 3, 31)) }
    let(:e3) { GapIsland::Element.new(:attribute => attr, :date_range => Date.civil(2017, 4, 1)..Date.civil(2017, 4, 30)) }
    let(:e4) { GapIsland::Element.new(:attribute => attr, :date_range => Date.civil(2017, 1, 15)..Date.civil(2017, 2, 28)) }
    let(:e5) { GapIsland::Element.new(:attribute => attr, :date_range => Date.civil(2017, 8, 15)..Date.civil(2017, 10, 31)) }
    let(:f1) { GapIsland::Element.new(:attribute => attr, :date_range => Date.civil(2017, 2, 1)..Date.civil(2017, 3, 31)) }
    let(:f2) { GapIsland::Element.new(:attribute => attr, :date_range => Date.civil(2017, 4, 1)..Date.civil(2017, 4, 30)) }
    let(:f3) { GapIsland::Element.new(:attribute => attr, :date_range => Date.civil(2017, 5, 1)..Date.civil(2017, 7, 31)) }
    let(:grouped_elements) { GapIsland::GroupElements.new(attribute: attr, elements: [e2, e1, f1, e3, e5]) }
    let(:p_e) { GapIsland::Partition.new([e2, e1, f1, e3, e5]).attribute(attr).combined_elements }
    it 'should do something' do
      expect(grouped_elements.size).to eq(2)
    end
    it 'should be the same' do
      expect(p_e.size).to eq(2)
    end
  end
end