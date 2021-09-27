require 'bankaccount'

describe BankAccount do 

  describe '.deposit' do
    it { is_expected.to respond_to(:deposit).with(2).arguments }
  end

  describe '.withdraw' do
    it { is_expected.to respond_to(:withdraw).with(2).arguments }
  end

  describe '.statement' do
    it { is_expected.to respond_to(:print_statement).with(0).arguments }
  end
end
