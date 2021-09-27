require 'Date'

class BankAccount

  def initialize
    @transactions = []
  end

  def deposit(amount)
    @transactions << {type: :deposit, date: "#{Date.today}", amount: amount}
  end

  def withdraw(amount)
    @transactions << {type: :withdrawal, date: "#{Date.today}", amount: amount}
  end

  def print_statement
    statement = ""
    @transactions.each_with_index do |transaction, i|
      if transaction[:type] == :deposit
        statement.prepend("\n #{transaction[:date]} || #{transaction[:amount]}.00 || || #{calc_balance(i)}.00")
      else 
        statement.prepend("\n #{transaction[:date]} || || #{transaction[:amount]}.00 || #{calc_balance(i)}.00")
      end
    end
    statement.prepend("date || credit || debit || balance")
  end

  private

  def calc_balance(i)
    balance = 0
    @transactions[0..i].each do |transaction|
      if transaction[:type] == :deposit
        balance += transaction[:amount]
      else
        balance -= transaction[:amount]
      end
    end
    balance
  end
end