# frozen_string_literal: true

require 'statement'

describe Statement do
  let(:statement_no_transactions) { described_class.new([]) }
  let(:statement_with_transactions) { described_class.new([
    { type: :deposit, date: '01/01/2021', amount: 100.00 },
    { type: :withdrawal, date: '03/10/2022', amount: 10.00 }
  ]) }

  it 'should respond to print_statment with no arguments' do
    expect(statement_no_transactions).to respond_to(:print_statement).with(0).arguments
  end

  describe '.print_statement' do
    it 'should print column headers' do
      expect { statement_no_transactions.print_statement }.to output("date || credit || debit || balance\n").to_stdout
    end

    it 'should print the transaction date' do
      expect { statement_with_transactions.print_statement }.to output(include('01/01/2021')).to_stdout
    end

    it 'should print deposits in the second column with empty third column' do
      expect { statement_with_transactions.print_statement }.to output(include('|| 100.00 || ||')).to_stdout
    end

    it 'should print withdrawals in the third column with empty second column' do
      expect { statement_with_transactions.print_statement }.to output(include('|| || 10.00 ||')).to_stdout
    end

    it 'should print account balance after each transaction has completed' do
      expect { statement_with_transactions.print_statement }.to output(include('90.00')).to_stdout
    end

    it 'should print transactions in reverse chronological order' do
      expect { statement_with_transactions.print_statement }.to output(
        "date || credit || debit || balance\n"\
        "03/10/2022 || || 10.00 || 90.00\n01/01/2021 || 100.00 || || 100.00\n"
      ).to_stdout
    end
  end
end
