require 'Date'

class BankAccount

  def initialize
    @transactions = []
  end

  def deposit(amount)
    raise "Please provide the amount in pounds and pence, e.g. 10.00" unless amount.is_a? Float
    raise "Deposit amount must be positive" if amount <= 0

    @transactions << {type: :deposit, date: "#{Date.today}", amount: amount.round(2)}
  end

  def withdraw(amount)
    raise "Please provide the amount in pounds and pence, e.g. 10.00" unless amount.is_a? Float
    raise "Deposit amount must be positive" if amount <= 0
    
    @transactions << {type: :withdrawal, date: "#{Date.today}", amount: amount.round(2)}
  end

  def print_statement
    statement = ""
    @transactions.each_with_index do |transaction, i|
      if transaction[:type] == :deposit
        statement.prepend("\n #{transaction[:date]} || #{'%.2f' % transaction[:amount]} || || #{calc_balance(i)}")
      else 
        statement.prepend("\n #{transaction[:date]} || || #{'%.2f' % transaction[:amount]} || #{calc_balance(i)}")
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
    '%.2f' % balance
  end
end