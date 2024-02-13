require 'test_helper'

class DashboardHelperTest < ActionView::TestCase
  test 'should return next friday date' do
    DistributionDateService.stubs(:next_date).returns(Date.parse('Friday 19th Jan 2024'))
    expected_date = 'Fri, 19 Jan 2024'
    assert_equal expected_date, next_distribution_date_formatted
  end

  test 'should format the created at attribute' do
    assert_equal '8th Nov 2023', created_at_formatted(dividends(:one))
  end

  test 'should count dividends of a given status' do
    assert_equal 2, status_count('issued', [dividends(:one), dividends(:issued)])
  end
end
