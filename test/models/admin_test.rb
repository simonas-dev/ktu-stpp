require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  def setup
    @record = Admin.create
    @record.email = 'test@admin.com'
    @record.password = '$' * 6
  end

  test 'valid record saving' do
    assert @record.save
  end

  test 'email format validation' do
    @record.email = 'invalid#email.format'
    assert !@record.valid?
  end

  test 'email presence validation' do
    @record.email = nil
    assert !@record.valid?
  end

  test 'password length validation' do
    @record.email = nil
    @record.password = '$' * 5
    assert !@record.valid?
  end
end
