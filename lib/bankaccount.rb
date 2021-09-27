require 'Date'

class BankAccount

  def initialize
    @transactions = []
  end

  def deposit(amount)
    check_validity(amount)
    @transactions << { type: :deposit, date: "#{transaction_date}", amount: amount.round(2) }
  end

  def withdraw(amount)
    check_validity(amount)
    @transactions << { type: :withdrawal, date: "#{transaction_date}", amount: amount.round(2) }
  end

  def print_statement
    statement = ""
    @transactions.each_with_index do |transaction, i|
      statement.prepend(create_statement_entry(transaction, i))
    end
    statement.prepend("date || credit || debit || balance")
  end

  private

  def transaction_date
    date = Date.today
    Date.parse(date).strftime('%d/%m/%Y')
  end

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

  def check_validity(amount)
    raise "Please provide the amount in pounds and pence, e.g. 10.00" unless amount.is_a? Float
    raise "Deposit amount must be positive" if amount <= 0
    raise "Please provide the amount in pounds and pence, e.g. 10.00" if amount.round(2) != amount
  end
end
