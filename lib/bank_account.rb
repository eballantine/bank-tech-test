# frozen_string_literal: true

require 'Date'
require_relative 'transaction_log'

# This class is responsible for allowing a user to interact with their bank account
class BankAccount
  attr_reader :transaction_log
  
  def initialize
    @transaction_log = TransactionLog.new
  end

  def deposit(amount)
    check_validity(amount)
    @transaction_log.create(:deposit, amount)
  end

  def withdraw(amount)
    check_validity(amount)
    return 'Insufficient funds to make this withdrawal' if amount > calc_balance

    @transaction_log.create(:withdrawal, amount)
  end

  def print_statement
    @statement = Statement.new(@transaction_log.transactions)
    @statement.print_statement
  end

  private

  def calc_balance
    balance = 0
    @transaction_log.transactions.each do |transaction|
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
