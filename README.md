# Bank tech test

Makers Week 10 technical task to practice producing high quality code without strict time pressure.<br>
Intended to be similar to a technical take-home task as part of a hiring process.<br>
The solution is all my own work. 

## Requirements
You should be able to interact with your code via a REPL like IRB or the JavaScript console.<br>
You don't need to implement a command line interface that takes input from STDIN.

### Functionality 
* Make deposits
* Make withdrawals
* Print statement of account (date, amount, balance).
* Data can be kept in memory (it doesn't need to be stored to a database or anything).

## Acceptance criteria
Given a client makes a deposit of 1000 on 10-01-2012<br>
And a deposit of 2000 on 13-01-2012<br>
And a withdrawal of 500 on 14-01-2012<br>
When she prints her bank statement<br>
Then she would see:<br>

date || credit || debit || balance<br>
14/01/2012 || || 500.00 || 2500.00<br>
13/01/2012 || 2000.00 || || 3000.00<br>
10/01/2012 || 1000.00 || || 1000.00<br>

## Focuses
* TDD
* OO design
* Code is readable
* Code is reliable
* Code is easy to maintain and change
* Self-review: Ability to assess code quality and improve my own code


## Plan
From the requirements I formed a domain model. The easiest implementation of the requirements that I could see would be to have 3 public methods; deposit, withdraw and print_statement.<br> 
The methods deposit and withdraw take 2 arguments, a date and an amount. Taking a date doesn't feel very parallel to real life as I would expect instead a timestamp matching the time the transation was completed. However, this is clearly needed by this bank based on the acceptance criteria - I suppose a bank may internally need a system that can make account changes retroactively (and/or even schedule future transactions). The amount should always be a positive either integer or float to 2 decimal places.<br> 
<br> 
_If no date is given should it default to today's date?_<br>
<br> 
_Should the bank be able to make non-sequential transactions?_ <br> 
If yes, transactions need to be ordered by date for print_statement. If no, guard for this.<br> 
<br> 
The print_statement method will take the stored transactions array and use a private calc_balance method to form each line of the statement and print. In the interests of keeping the statement a sensible length for customers who bank frequently and/or long term - <br> 
 <br> 
_Should the statement be restricted to print just the latest month, or latest 30 transactions, or similar?_ <br> 
 <br> 
![Domain model for bank account](/images/plan.png)
