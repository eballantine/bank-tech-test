class BankAccount
  attr_reader :transactions

  def initialize
    @transactions = []
  end

  def deposit(amount)
  end

  def withdraw(amount)
  end

  def print_statement
    "date || credit || debit || balance"
  end
end
