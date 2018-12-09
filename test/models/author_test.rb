require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  def setup
    @record = Author.create
    @record.first_name = 'Simonas'
    @record.last_name = 'Sankauskas'
    @record.group = 'IFF-5/3'
  end

  test 'a valid record saving' do
    assert @record.save
  end

  test 'first name presence validation' do
    @record.first_name = nil
    assert !@record.valid?
  end

  test 'last name presence validation' do
    @record.last_name = nil
    assert !@record.valid?
  end

  test 'group format validation' do
    @record.group = 'iff-a/3'
    assert !@record.valid?
  end
end
