# frozen_string_literal: true

require 'Date'

# This class is responsible for allowing a user to interact with their bank account
class BankAccount
  def initialize
    @transaction_log = TransactionLog.new
  end

  def deposit(amount)
    check_validity(amount)
    @transaction_log.create(:deposit, amount)
    "Deposit complete"
  end

  def withdraw(amount)
    check_validity(amount)
    return 'Insufficient funds to make this withdrawal' if amount > calc_balance

    @transaction_log.create(:withdrawal, amount)
    "Withdrawal complete"
  end

  def print_statement
    statement = +''
    @transaction_log.transactions.each_with_index do |transaction, index|
      statement.prepend(create_statement_entry(transaction, index))
    end
    statement.prepend('date || credit || debit || balance')
  end

  private

  def create_statement_entry(transaction, index)
    if transaction[:type] == :deposit
      "\n#{transaction[:date]} || #{format('%.2f', transaction[:amount])} || || #{calc_running_balance(index)}"
    else
      "\n#{transaction[:date]} || || #{format('%.2f', transaction[:amount])} || #{calc_running_balance(index)}"
    end
  end

  def calc_running_balance(index)
    balance = 0

    @transaction_log.transactions[0..index].each do |transaction|
      transaction[:type] == :deposit ? balance += transaction[:amount] : balance -= transaction[:amount]
    end
    format('%.2f', balance)
  end

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
