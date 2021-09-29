# frozen_string_literal: true

require_relative 'transaction'
require_relative 'statement'

# This class is responsible for allowing a user to interact with their bank account
class BankAccount
  def initialize
    @transactions = []
  end

  def deposit(amount)
    check_validity(amount)
    @transactions << Transaction.new.create(:deposit, amount)
    'Deposit complete'
  end

  def withdraw(amount)
    check_validity(amount)
    return 'Insufficient funds to make this withdrawal' if amount > calc_balance

    @transactions << Transaction.new.create(:withdrawal, amount)
    'Withdrawal complete'
  end

  def print_statement
    @statement = Statement.new(@transactions)
    @statement.print_statement
  end

  private
  
  attr_reader :transactions

  def calc_balance
    balance = 0
    @transactions.each do |transaction|
      transaction[:type] == :deposit ? balance += transaction[:amount] : balance -= transaction[:amount]
    end
    balance
  end

  def check_validity(amount)
    raise 'Please provide the amount in pounds and pence, e.g. 10.00' unless amount.is_a? Float
    raise 'Deposit amount must be positive' if amount <= 0
    raise 'Please provide the amount in pounds and pence, e.g. 10.00' if amount.round(2) != amount
  end
end
