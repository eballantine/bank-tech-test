# frozen_string_literal: true

require 'bankaccount'

describe BankAccount do
  let(:not_float_error) { 'Please provide the amount in pounds and pence, e.g. 10.00' }
  let(:not_positive_error) { 'Deposit amount must be positive' }
  let(:insufficient_funds_error) { 'Insufficient funds to make this withdrawal' }

  before(:each) do
    allow(Date).to receive(:today).and_return('2021-01-01')
  end

  it { is_expected.to respond_to(:deposit).with(1).arguments }
  it { is_expected.to respond_to(:withdraw).with(1).arguments }
  it { is_expected.to respond_to(:print_statement).with(0).arguments }

  describe '.deposit' do
    it 'should raise an error if not given a float' do
      expect { subject.deposit('Hello!') }.to raise_exception(RuntimeError, not_float_error)
    end

    it 'should raise an error if not given a positive number' do
      expect { subject.deposit(-10.00) }.to raise_exception(RuntimeError, not_positive_error)
    end

    it 'should raise an error if given a float with anything other than 2 decimal places' do
      expect { subject.deposit(10.123) }.to raise_exception(RuntimeError, not_float_error)
    end

    it 'should accept amounts which include pennies (not whole pounds)' do
      expect { subject.deposit(9.99) }.not_to raise_exception
    end
  end

  describe '.withdraw' do
    before(:each) do
      subject.deposit(100.00)
    end

    it 'should raise an error if not given a float' do
      expect { subject.withdraw('Hello!') }.to raise_exception(RuntimeError, not_float_error)
    end

    it 'should raise an error if not given a positive number' do
      expect { subject.withdraw(-10.00) }.to raise_exception(RuntimeError, not_positive_error)
    end

    it 'should raise an error if given a float with anything other than 2 decimal places' do
      expect { subject.withdraw(10.123) }.to raise_exception(RuntimeError, not_float_error)
    end

    it 'should return if attempting to withdraw more than the current balance' do
      expect(subject.withdraw(500.00)).to eq(insufficient_funds_error)
    end

    it 'should accept amounts which include pennies (not whole pounds)' do
      expect { subject.withdraw(9.99) }.not_to raise_exception
    end

    it 'should return a success message if withdrawal is successful' do
      expect(subject.withdraw(10.00)).to eq "Withdrawal complete"
    end
  end

  describe '.print_statement' do
    it 'should print column headers' do
      expect(subject.print_statement).to start_with('date || credit || debit || balance')
    end

    it 'should print the transaction date' do
      subject.deposit(150.00)
      expect(subject.print_statement).to include('01/01/2021')
    end

    it 'should print deposits in the second column with empty third column' do
      subject.deposit(100.00)
      expect(subject.print_statement).to include('|| 100.00 || ||')
    end

    it 'should print withdrawals in the third column with empty second column' do
      subject.deposit(300.00)
      subject.withdraw(100.00)
      expect(subject.print_statement).to include('|| || 100.00 ||')
    end

    it 'should print account balance after each transaction has completed' do
      subject.deposit(150.00)
      expect(subject.print_statement).to end_with('150.00')
    end

    it 'should print transactions in reverse chronological order' do
      subject.deposit(200.00)
      subject.withdraw(10.00)
      expect(subject.print_statement).to eq(
        "date || credit || debit || balance\n"\
        "01/01/2021 || || 10.00 || 190.00\n01/01/2021 || 200.00 || || 200.00"
      )
    end

    context 'many deposits and withdrawals' do
      it 'should correctly print the statement' do
        2.times do
          subject.deposit(200.00)
          subject.withdraw(10.00)
          subject.deposit(52.12)
          subject.withdraw(999.00)
        end
        expect(subject.print_statement).to eq(
          "date || credit || debit || balance\n"\
          "01/01/2021 || 52.12 || || 484.24\n"\
          "01/01/2021 || || 10.00 || 432.12\n"\
          "01/01/2021 || 200.00 || || 442.12\n"\
          "01/01/2021 || 52.12 || || 242.12\n"\
          "01/01/2021 || || 10.00 || 190.00\n"\
          '01/01/2021 || 200.00 || || 200.00'
        )
      end
    end
  end
end
