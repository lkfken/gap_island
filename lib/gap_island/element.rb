require 'kl/date_range'
require 'yaml'
class Element

  attr_accessor :attribute, :date_range

  def initialize(attribute: nil, date_range: nil)
    @attribute  = attribute
    @date_range = date_range
  end

  def begin_date
    date_range.first
  end

  def end_date
    date_range.last
  end

  def to_s
    { attribute: attribute.to_s, range: begin_date..end_date }.to_s
  end

  def <=>(element)
    [begin_date, end_date] <=> [element.begin_date, element.end_date]
  end

  def ==(element)
    same_attribute?(element) && begin_date == element.begin_date && end_date == element.end_date
  end

  def same_attribute?(element)
    attribute == element.attribute
  end

  def dates
    @dates ||= KL::DateRange(date_range).every(:days => 1)
  end
end