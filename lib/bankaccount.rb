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
    balance = 0
    @transactions.each do |transaction|
      balance += transaction[:amount]
      statement += "\n #{transaction[:amount]}.00 || #{balance}.00"
    end
    statement
  end
end
