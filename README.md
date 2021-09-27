# Bank tech test

Makers Week 10 technical task to practice producing high quality code without strict time pressure.<br>
Intended to be similar to a technical take-home task as part of a hiring process.<br>
The solution is all my own work. 

## Installation

Ruby version >= 3.0.1 required. [Install Ruby](https://www.ruby-lang.org/en/documentation/installation/)

Install dependencies:<br> 
```bundle install```

## Run tests

Run ```rspec -fd``` to see all test descriptions, each test's pass/fail status, and simplecov's summary of code coverage.

## Run program

To run the program, ensure you're in the root folder of the project and start an interactive Ruby session from your terminal:<br>
```irb```
Require the code:<br>
```require './lib/bankaccount.rb'```
Create a new bank account:<br>
```my_account = BankAccount.new```
You're now free to make deposits, withdrawals, or check your statement as you see fit:<br>
****** TO DO Screenshot of it in action. ***** 

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

## Plan, how I structured my code and why

From the requirements I formed a domain model. The easiest implementation of the requirements that I could see would be to have 3 public methods; deposit, withdraw and print_statement.<br> 
The methods deposit and withdraw take 1 argument, an amount. The amount should always be a positive either integer or float to 2 decimal places.<br> 
A transaction will be recorded following a deposit or withdrawal with a timestamp of when the transaction occured.
<br> 
The print_statement method will take the stored transactions array and use a private calc_balance method to form each line of the statement and print. In the interests of keeping the statement a sensible length for customers who bank frequently and/or long term -<br> 
<br> 
_Should the statement be restricted to print just the latest month, or latest 30 transactions, or similar?_ <br> 
 <br> 
Without mention of overdraft facility, I will restrict the bankaccount from allowing a withdrawal greater than the current balance.<br>
<br>
![Domain model for bank account](/images/plan.png)
