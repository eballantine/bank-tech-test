# frozen_string_literal: true

require 'transaction_log'

describe TransactionLog do
  before(:each) do
    allow(Date).to receive(:today).and_return('2021-01-01')
  end

  it 'is initialized with 0 arguments' do
    expect(described_class).to respond_to(:new).with(0).arguments
  end

  it 'prints "Deposit complete" when it creates a new deposit' do
    expect(subject.create(:deposit, 10.00)).to eq "Deposit complete"
  end

  it 'prints "Withdrawal complete" when it creates a new withdrawal' do
    expect(subject.create(:withdrawal, 10.00)).to eq "Withdrawal complete"
  end
end
