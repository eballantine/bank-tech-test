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
    @transactions.each_with_index do |transaction, i|
      statement += "\n #{transaction[:amount]}.00 || #{calc_balance(i)}.00"
    end
    statement
  end

  private

  def calc_balance(i)
    balance = 0
    @transactions[0..i].each do |transaction|
      balance += transaction[:amount]
    end
    balance
  end
end
