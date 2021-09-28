# frozen_string_literal: true

require 'statement'

describe Statement do
  it { is_expected.to respond_to(:print_statement).with(1).argument }
end
