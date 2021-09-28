# frozen_string_literal: true

require 'statement'

describe Statement do
  let(:transaction_log) { double("TransactionLog", transactions: []) }

  it { is_expected.to respond_to(:print_statement).with(1).argument }

  describe '.print_statement' do
    it 'should print column headers' do
      expect(subject.print_statement(transaction_log)).to start_with('date || credit || debit || balance')
    end
  end
end
