require 'bankaccount'

describe BankAccount do 
  before(:each) do 
    allow(Date).to receive(:today).and_return("2021-01-01")
  end
  
  # test for TDD, not needed in final test suite
  it 'starts with no transactions recorded' do
    expect(subject.transactions).to eq []
  end

  describe '.deposit' do

    it { is_expected.to respond_to(:deposit).with(1).arguments }

    # test for TDD, not needed in final test suite
    it 'adds a date/amount hash to transactions' do
      subject.deposit(100)
      expect(subject.transactions).to eq [{ :"2021-01-01" => 100 }]
    end
  end

  describe '.withdraw' do
    it { is_expected.to respond_to(:withdraw).with(1).arguments }
  end

  describe '.print_statement' do
    it { is_expected.to respond_to(:print_statement).with(0).arguments }

    it 'should print headers' do
      expect(subject.print_statement).to eq('date || credit || debit || balance')
    end
  end
end
