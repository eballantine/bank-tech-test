require 'Date'

class BankAccount
  attr_reader :transactions

  def initialize
    @transactions = []
  end

  def deposit(amount)
    @transactions << {:"#{Date.today}" => amount}
  end

  def withdraw(amount)
    @transactions << {:"#{Date.today}" => -amount}
  end

  def print_statement
    "date || credit || debit || balance"
  end
end
