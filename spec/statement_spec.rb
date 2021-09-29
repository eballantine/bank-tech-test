# frozen_string_literal: true

require 'statement'

describe Statement do
  let(:statement) { described_class.new([]) }

  it 'should respond to print_statment with no arguments' do
    expect(statement).to respond_to(:print_statement).with(0).arguments
  end

  describe '.print_statement' do
    it 'should puts statement to terminal' do
      expect { statement.print_statement }.to output(
        "date || credit || debit || balance\n").to_stdout
    end
  end
end
