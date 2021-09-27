require 'Date'

class BankAccount

  def initialize
    @transactions = []
  end

  def deposit(amount)
    valid_amount?(amount)
    date = Date.today
    @transactions << {type: :deposit, date: "#{Date.parse(date).strftime('%d/%m/%Y')}", amount: amount.round(2)}
  end

  def withdraw(amount)
    valid_amount?(amount)
    date = Date.today
    @transactions << {type: :withdrawal, date: "#{Date.parse(date).strftime('%d/%m/%Y')}", amount: amount.round(2)}
  end

  def print_statement
    statement = ""
    @transactions.each_with_index do |transaction, i|
      statement.prepend(create_statement_entry(transaction, i))
    end
    statement.prepend("date || credit || debit || balance")
  end

  private

  def create_statement_entry(transaction, i)
    if transaction[:type] == :deposit
      "\n #{transaction[:date]} || #{'%.2f' % transaction[:amount]} || || #{calc_balance(i)}"
    else
      "\n #{transaction[:date]} || || #{'%.2f' % transaction[:amount]} || #{calc_balance(i)}"
    end
  end

  def calc_balance(i)
    balance = 0
    @transactions[0..i].each do |transaction|
      transaction[:type] == :deposit ? balance += transaction[:amount] : balance -= transaction[:amount]
    end
    '%.2f' % balance
  end

  def valid_amount?(amount)
    raise "Please provide the amount in pounds and pence, e.g. 10.00" unless amount.is_a? Float
    raise "Deposit amount must be positive" if amount <= 0
  end
end