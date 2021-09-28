# frozen_string_literal: true

# This class is responsible for generating bank statements
class Statement
  def initialize(transactions)
    @transactions = transactions
  end

  def print_statement
    statement = +''
    if @transactions.length > 0
      @transactions.each_with_index do |transaction, index|
        statement.prepend(create_statement_entry(transaction, index))
      end
    end
    statement.prepend('date || credit || debit || balance')
    puts statement
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

    @transactions[0..index].each do |transaction|
      transaction[:type] == :deposit ? balance += transaction[:amount] : balance -= transaction[:amount]
    end
    format('%.2f', balance)
  end
end
