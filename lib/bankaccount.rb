require 'Date'

class BankAccount
  attr_reader :transactions

  def initialize
    @transactions = []
  end

  def deposit(amount)
    @transactions << {:date => "#{Date.today}", :amount => amount}
  end

  def withdraw(amount)
    @transactions << {:date => "#{Date.today}", :amount => -amount}
  end

  def print_statement
    statement = "date || credit || debit || balance"
  end
end
