require 'bankaccount'

describe BankAccount do 
  before(:each) do 
    allow(Date).to receive(:today).and_return("2021-01-01")
  end

  describe '.deposit' do
    it { is_expected.to respond_to(:deposit).with(1).arguments }

    it 'raises an error if not given a number' do
      expect { subject.deposit("Hello!") }.to raise_exception(RuntimeError, "Please provide the amount in pounds and pence, e.g. 10.00" )
    end

    it 'raises an error if not given a positive number' do
      expect { subject.deposit(-10.00) }.to raise_exception(RuntimeError, "Deposit amount must be positive")
    end

    it 'should show on the statement' do
      subject.deposit(200.00)
      expect(subject.print_statement).to include("200.00")
    end
  end

  describe '.withdraw' do
    it { is_expected.to respond_to(:withdraw).with(1).arguments }

    it 'raises an error if not given a number' do
      expect { subject.withdraw("Hello!") }.to raise_exception(RuntimeError, "Please provide the amount in pounds and pence, e.g. 10.00" )
    end

    it 'raises an error if not given a positive number' do
      expect { subject.withdraw(-10.00) }.to raise_exception(RuntimeError, "Deposit amount must be positive")
    end

    it 'should show on the statement' do
      subject.withdraw(300.00)
      expect(subject.print_statement).to include("300.00")
    end
  end

  describe '.print_statement' do
    it { is_expected.to respond_to(:print_statement).with(0).arguments }

    it 'should print headers' do
      expect(subject.print_statement).to eq('date || credit || debit || balance')
    end

    it 'should print balance with transactions' do
      subject.deposit(150.00)
      subject.withdraw(50.00)
      expect(subject.print_statement).to include("100.00")
    end

    it 'should print date with transactions' do
      subject.deposit(150.00)
      expect(subject.print_statement).to include("01/01/2021")
    end

    it 'should print deposits in the second column' do
      subject.deposit(100.00)
      expect(subject.print_statement).to include "100.00 || ||"
    end

    it 'should print withdrawals in the third column' do
      subject.withdraw(100.00)
      expect(subject.print_statement).to include "|| || 100.00"
    end

    it 'should print transactions in reverse chronological order' do
      subject.deposit(200.00)
      subject.withdraw(10.00)
      expect(subject.print_statement).to eq "date || credit || debit || balance\n 01/01/2021 || || 10.00 || 190.00\n 01/01/2021 || 200.00 || || 200.00"
    end
  end
end
