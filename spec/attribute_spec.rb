require 'rspec'
require_relative '../lib/gap_island/attribute'

describe GapIsland::Attribute do
  let(:attr1) { GapIsland::Attribute.new('a') }
  let(:attr2) { GapIsland::Attribute.new('a') }
  it 'should do something' do
    expect(attr1 == attr2).to be_truthy
  end
  it 'should do something' do
    expect(attr1 == attr1).to be_truthy
  end
  it 'should do something' do
    expect(attr1 === attr2).to be_truthy
  end
end