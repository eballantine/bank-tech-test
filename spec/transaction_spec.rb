# frozen_string_literal: true

require 'transaction_log'

describe TransactionLog do
  it 'is initialized with 0 arguments' do
    expect(described_class).to respond_to(:new).with(0).arguments
  end
end
