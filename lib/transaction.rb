# frozen_string_literal: true

# This class is responsible for creating account transactions (deposits and withdrawals)
class Transaction

  def create(type, amount)
    type == :deposit ? (print "Deposit complete") : (print "Withdrawal complete")
    { type: type, date: transaction_date, amount: amount.round(2) }
  end

  private

  def transaction_date
    date = Date.today.to_s
    Date.parse(date).strftime('%d/%m/%Y').to_s
  end
end
