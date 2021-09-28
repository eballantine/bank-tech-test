# frozen_string_literal: true

require 'statement'

describe Statement do
  let(:statement) { described_class.new([]) }

  it 'should respond to print_statment with no arguments' do
    expect(statement).to respond_to(:print_statement).with(0).arguments
  end
end
