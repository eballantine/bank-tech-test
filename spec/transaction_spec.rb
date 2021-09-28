# frozen_string_literal: true

require 'transaction'

describe Transaction do
  it { is_expected.to respond_to(:create).with(2).arguments }
end
