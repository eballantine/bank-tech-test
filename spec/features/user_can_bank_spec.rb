# frozen_string_literal: true

require 'bank_account'

describe BankAccount do
  before(:each) do
    allow(Date).to receive(:today).and_return('2021-01-01')
  end

  context 'many deposits and withdrawals' do
    it 'should correctly print the statement' do
      2.times do
        subject.deposit(200.00)
        subject.withdraw(10.00)
        subject.deposit(52.12)
        subject.withdraw(999.00)
      end
      expect { subject.print_statement }.to output(
        "date || credit || debit || balance\n"\
        "01/01/2021 || 52.12 || || 484.24\n"\
        "01/01/2021 || || 10.00 || 432.12\n"\
        "01/01/2021 || 200.00 || || 442.12\n"\
        "01/01/2021 || 52.12 || || 242.12\n"\
        "01/01/2021 || || 10.00 || 190.00\n"\
        "01/01/2021 || 200.00 || || 200.00\n"
      ).to_stdout
    end
  end
end
