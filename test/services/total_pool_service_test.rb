require 'test_helper'

class TotalPoolServiceTest < ActiveSupport::TestCase
  test 'balance_in_base_units' do
    TotalPoolCalculationsService.stubs(:total_contributions_by_currency)
      .returns({ 'AUD' => 10_000 })

    TotalPoolCalculationsService.stubs(:total_owed_dividends_by_currency)
      .returns({ 'AUD' => 500 })

    TotalPoolCalculationsService.stubs(:total_paid_out_by_currency)
      .returns({ 'AUD' => 1_000 })

    Expense.stubs(:sum).returns(1_000).once

    assert_equal 7_500, TotalPoolService.balance_in_base_units
  end

  test 'balance in base units integration' do
    stub_eu_central_bank_request

    assert_instance_of Integer, TotalPoolService.balance_in_base_units
  end

  test 'balance_formatted' do
    TotalPoolService.stubs(:balance_in_base_units).returns(10_000)

    assert_equal '$100.00 AUD', TotalPoolService.balance_formatted('AUD')
  end

  test 'total_contributed_and_recontributed_formatted' do
    TotalPoolCalculationsService.stubs(:total_contributions_by_currency)
      .returns({ 'AUD' => 10_000 })

    TotalPoolCalculationsService.stubs(:total_recontributions_by_currency)
      .returns({ 'AUD' => 10_000 })

    assert_equal '$200.00 AUD', TotalPoolService.total_contributed_and_recontributed_formatted('AUD')
  end

  test 'total_paid_out_formatted' do
    TotalPoolCalculationsService.stubs(:total_paid_out_by_currency)
      .returns({ 'AUD' => 10_000 })

    assert_equal '$100.00 AUD', TotalPoolService.total_paid_out_formatted('AUD')
  end

  test 'total_dividends_formatted' do
    TotalPoolCalculationsService.stubs(:total_dividends_by_currency)
      .returns({ 'AUD' => 10_000 })

    assert_equal '$100.00 AUD', TotalPoolService.total_dividends_formatted('AUD')
  end

  test 'balance formatted integration' do
    stub_eu_central_bank_request

    assert_instance_of String, TotalPoolService.balance_formatted('AUD')
  end
end
