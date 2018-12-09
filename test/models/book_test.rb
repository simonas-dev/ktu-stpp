require 'test_helper'

class BookTest < ActiveSupport::TestCase
  def setup
    @record = Book.create
    @record.name = '+' * 256
    @record.summmary = '+' * 1000
    @record.page_count = 555
  end

  test 'valid record saving' do
    assert @record.save
  end

  test 'page count validation' do
    @record.page_count = -1
    assert !@record.valid?
  end

  test 'name length validation' do
    @record.name = '-' * 257
    assert !@record.valid?
  end

  test 'name presence validation' do
    @record.name = nil
    assert !@record.valid?
  end

  test 'summmary length validation' do
    @record.summmary = '-' * 1001
    assert !@record.valid?
  end

  test 'summmary presence validation' do
    @record.summmary = nil
    assert !@record.valid?
  end
end
