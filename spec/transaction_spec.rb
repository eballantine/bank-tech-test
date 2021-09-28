# frozen_string_literal: true

require 'transaction'

describe Transaction do
  it 'is initialized with 2 arguments' do
    expect(described_class).to respond_to(:new).with(2).arguments
  end
end
