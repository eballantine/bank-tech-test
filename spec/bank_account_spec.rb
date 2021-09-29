# frozen_string_literal: true

require 'bank_account'

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
    context 'successful' do
      it 'should accept amounts which include pennies (not only whole pounds)' # do
      #   expect { subject.deposit(9.99) }.not_to raise_exception
      # end

      it 'should make a transaction instance & pass it :deposit and amount'

      it 'should return a success message if deposit is successful' do
        expect(subject.deposit(10.00)).to eq 'Deposit complete'
      end
    end

    context 'unsuccessful' do
      it 'should raise an error if not given a float' do
        expect { subject.deposit('Hello!') }.to raise_exception(RuntimeError, not_float_error)
      end

      it 'should raise an error if not given a positive number' do
        expect { subject.deposit(-10.00) }.to raise_exception(RuntimeError, not_positive_error)
      end

      it 'should raise an error if given a float with anything other than 2 decimal places' do
        expect { subject.deposit(10.123) }.to raise_exception(RuntimeError, not_float_error)
      end
    end
  end

  describe '.withdraw' do
    before(:each) do
      subject.deposit(100.00)
    end

    context 'successful' do
      it 'should accept amounts which include pennies (not only whole pounds)' do
        expect { subject.withdraw(9.99) }.not_to raise_exception
      end

      it 'should return a success message if withdrawal is successful' do
        expect(subject.withdraw(10.00)).to eq 'Withdrawal complete'
      end

      it 'should make a transaction instance & pass it :deposit and amount'

    end

    context 'unsuccessful' do
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
    end
  end

  describe '.print_statement' do
    it 'should create a new statement instance, should pass it transactions & run print method on it'
  end
end
