require 'bankaccount'

describe BankAccount do 
  before(:each) do 
    allow(Date).to receive(:today).and_return("2021-01-01")
  end

  describe '.deposit' do
    it { is_expected.to respond_to(:deposit).with(1).arguments }

    it 'should show on the statement' do
      subject.deposit(200)
      expect(subject.print_statement).to include("200.00")
    end
  end

  describe '.withdraw' do
    it { is_expected.to respond_to(:withdraw).with(1).arguments }

    it 'should show on the statement' do
      subject.withdraw(300)
      expect(subject.print_statement).to include("300.00")
    end
  end

  describe '.print_statement' do
    it { is_expected.to respond_to(:print_statement).with(0).arguments }

    it 'should print headers' do
      expect(subject.print_statement).to eq('date || credit || debit || balance')
    end

    it 'should print balance with transactions' do
      subject.deposit(150)
      subject.withdraw(50)
      expect(subject.print_statement).to include("100.00")
    end

    it 'should print date with transactions' do
      subject.deposit(150)
      expect(subject.print_statement).to include("2021-01-01")
    end

    it 'should print deposits in the second column' do
      subject.deposit(100)
      expect(subject.print_statement).to include "100.00 || ||"
    end

    it 'should print withdrawals in the third column' do
      subject.withdraw(100)
      expect(subject.print_statement).to include "|| || 100.00"
    end

    it 'should print transactions in reverse chronological order' do
      subject.deposit(200)
      subject.withdraw(10)
      expect(subject.print_statement).to eq "date || credit || debit || balance\n 2021-01-01 || || 10.00 || 190.00\n 2021-01-01 || 200.00 || || 200.00"
    end
  end
end
