require 'bankaccount'

describe BankAccount do 

  describe '.deposit' do
    it { is_expected.to respond_to(:deposit).with(2).arguments }
  end
end
