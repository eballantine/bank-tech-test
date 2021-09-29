# frozen_string_literal: true

require 'transaction'

describe Transaction do
  it { should respond_to(:create).with(2).arguments }

  describe '.create' do
    it 'should create a hash with 3 key/value pairs, type date and amount' do
      allow(Date).to receive(:today).and_return('2021-01-01')
      expect(subject.create(:deposit, 10.00)).to eq({ type: :deposit, date: '01/01/2021', amount: 10.00 })
    end
  end
end
