require "spec_helper"
require 'pp'
describe GapIsland do
  let(:data) { build(:no_gaps) }
  let(:elements) { FactoryGirl.factories }
  let(:attr1) { GapIsland::Attribute.new(['A', '1']) }
  let(:attr2) { GapIsland::Attribute.new(['A', '2']) }
  let(:e1) { Element.new(:attribute => attr1, :date_range => Date.civil(2017, 1, 1)..Date.civil(2017, 1, 31)) }
  let(:e2) { Element.new(:attribute => attr1, :date_range => Date.civil(2017, 2, 1)..Date.civil(2017, 3, 31)) }
  let(:e3) { Element.new(:attribute => attr1, :date_range => Date.civil(2017, 4, 1)..Date.civil(2017, 4, 30)) }
  let(:e4) { Element.new(:attribute => attr1, :date_range => Date.civil(2017, 1, 15)..Date.civil(2017, 2, 28)) }
  let(:f1) { Element.new(:attribute => attr2, :date_range => Date.civil(2017, 2, 1)..Date.civil(2017, 3, 31)) }
  let(:f2) { Element.new(:attribute => attr2, :date_range => Date.civil(2017, 4, 1)..Date.civil(2017, 4, 30)) }
  let(:f3) { Element.new(:attribute => attr2, :date_range => Date.civil(2017, 5, 1)..Date.civil(2017, 7, 31)) }

  context 'combine periods if no gap' do
    let(:result) { GapIsland::Arithmetic.new.group(e1, e2) }
    it 'should only have 1 segment after grouping' do
      expect(result.size).to eq(1)
    end
    it 'should start on 1/1/2017' do
      expect(result.first.begin_date).to eq(Date.civil(2017, 1, 1))
    end
    it 'should end on 3/31/2017' do
      expect(result.first.end_date).to eq(Date.civil(2017, 3, 31))
    end
  end

  context 'combine periods if no gap - reverse' do
    let(:result) { GapIsland::Arithmetic.new.group(e2, e1) }
    it 'should only have 1 segment after grouping' do
      expect(result.size).to eq(1)
    end
    it 'should start on 1/1/2017' do
      expect(result.first.begin_date).to eq(Date.civil(2017, 1, 1))
    end
    it 'should end on 3/31/2017' do
      expect(result.first.end_date).to eq(Date.civil(2017, 3, 31))
    end
  end

  context 'combine periods if no gap - overlap' do
    let(:result) { GapIsland::Arithmetic.new.group(e1, e4) }
    it 'should only have 1 segment after grouping' do
      expect(result.size).to eq(1)
    end
    it 'should start on 1/1/2017' do
      expect(result.first.begin_date).to eq(Date.civil(2017, 1, 1))
    end
    it 'should end on 3/31/2017' do
      expect(result.first.end_date).to eq(Date.civil(2017, 2, 28))
    end
  end

  context 'not combine periods if gap exist' do
    let(:result) { GapIsland::Arithmetic.new.group(e1, e3) }
    it 'should only have 1 segment after grouping' do
      expect(result.size).to eq(2)
    end
    it 'should start on 1/1/2017' do
      expect(result.first).to eq(e1)
    end
    it 'should end on 3/31/2017' do
      expect(result.last).to eq(e3)
    end
  end

  context 'raise exception if attribute is not identical' do
    let(:arith) { GapIsland::Arithmetic.new }
    it 'should raise exception' do
      expect { arith.group(e1, f1) }.to raise_error(GapIsland::DifferentAttrError)
    end
  end

  context 'elements grouped by attributes = partition' do
    let(:partition) { GapIsland::Partition.new([e2, e1, f1, e3]) }
    it '#count' do
      expect(partition.count).to eq 2
    end

    it 'should able to extract by given an attribute' do
      expect(partition.key(attr1).elements).to eq([e1, e2, e3])
    end

    context 'combined partition elements' do
      let(:combined_elements){partition.key(attr1).combined_elements}
      it 'should combine elements' do
        expect(combined_elements.size).to eq(1)
      end
      it 'should have this start date' do
        expect(combined_elements.first.begin_date).to eq(e1.begin_date)
      end
      it 'should have this end date' do
        expect(combined_elements.first.end_date).to eq(e3.end_date)
      end
    end
  end
end