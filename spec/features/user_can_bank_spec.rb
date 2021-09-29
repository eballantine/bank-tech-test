# frozen_string_literal: true

require 'bank_account'

describe BankAccount do
  let(:not_float_error) { 'Please provide the amount in pounds and pence, e.g. 10.00' }
  let(:not_positive_error) { 'Deposit amount must be positive' }
  let(:insufficient_funds_error) { 'Insufficient funds to make this withdrawal' }

  before(:each) do
    allow(Date).to receive(:today).and_return('2021-01-01')
  end

  describe '.print_statement' do
    it 'should print column headers' do
      expect { subject.print_statement }.to output("date || credit || debit || balance\n").to_stdout
    end

    it 'should print the transaction date' do
      subject.deposit(150.00)
      expect { subject.print_statement }.to output(include('01/01/2021')).to_stdout
    end

    it 'should print deposits in the second column with empty third column' do
      subject.deposit(100.00)
      expect { subject.print_statement }.to output(include('|| 100.00 || ||')).to_stdout
    end

    it 'should print withdrawals in the third column with empty second column' do
      subject.deposit(300.00)
      subject.withdraw(100.00)
      expect { subject.print_statement }.to output(include('|| || 100.00 ||')).to_stdout
    end

    it 'should print account balance after each transaction has completed' do
      subject.deposit(150.00)
      expect { subject.print_statement }.to output(include('150.00')).to_stdout
    end

    it 'should print transactions in reverse chronological order' do
      subject.deposit(200.00)
      subject.withdraw(10.00)
      expect { subject.print_statement }.to output(
        "date || credit || debit || balance\n"\
        "01/01/2021 || || 10.00 || 190.00\n01/01/2021 || 200.00 || || 200.00\n"
      ).to_stdout
    end
  end

  context 'many deposits and withdrawals' do
    it 'should correctly print the statement' do
      2.times do
        subject.deposit(200.00)
        subject.withdraw(10.00)
        subject.deposit(52.12)
        subject.withdraw(999.00)
      end
      expect { subject.print_statement }.to output(
        "date || credit || debit || balance\n"\
        "01/01/2021 || 52.12 || || 484.24\n"\
        "01/01/2021 || || 10.00 || 432.12\n"\
        "01/01/2021 || 200.00 || || 442.12\n"\
        "01/01/2021 || 52.12 || || 242.12\n"\
        "01/01/2021 || || 10.00 || 190.00\n"\
        "01/01/2021 || 200.00 || || 200.00\n"
      ).to_stdout
    end
  end
end
