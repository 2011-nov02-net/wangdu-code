using System;
using System.Collections.Generic;

namespace classes
// namespace provides a way to logically organize your code 
{
    public class BankAccount
    //define the class or type, you are creating
    {
        private static int accountNumberSeed = 123456789;   
        //Properties: Data elements and can have code that enforces validation or other rules
        public string Number { get; }
        public string Owner { get; set; }
        public decimal Balance
        { 
            get
            {
                decimal balance = 0;
                foreach (var item in allTransactions)
                {
                    balance += item.Amount;
                }
                return balance;
            } 
        }


        //Constructor: used to initialize objects of that class type
        // - it is called when you create an object using new.
        public BankAccount(string name, decimal initialBalance)
        {
            this.Number = accountNumberSeed.ToString();
            accountNumberSeed++;

            this.Owner = name;
            MakeDeposit(initialBalance, DateTime.Now, "Initial balance");
            // DateTime.Now is property that returns the current date and time.
        }
        
        // 
        private List<Transaction> allTransactions = new List<Transaction>();

        //Methods: a block of code that perform a single function
        public void MakeDeposit(decimal amount, DateTime date, string note)
        {
            if (amount <= 0 )
            {
                throw new ArgumentOutOfRangeException(nameof(amount), "Amount of deposit must be positive");
            }
            var deposit = new Transaction(amount, date, note);
            allTransactions.Add(deposit);
        }

        public void MakeWithdrawal(decimal amount, DateTime date, string note)
        {
            if(amount <= 0)
            {
                throw new ArgumentOutOfRangeException(nameof(amount), "Amount of withdrawl must be positive");
                // an exception is thrown when the balance become negative
            }
            if(Balance - amount < 0)
            {
                throw new InvalidOperationException("Not sufficient funds for this withdrawl");
            }
            var withdrawl = new Transaction(-amount, date, note);
            allTransactions.Add(withdrawl);
        }
        public string GetAccountHistory()
        {       
            var report = new System.Text.StringBuilder();

            decimal balance = 0;
            report.AppendLine("Date\t\tAmount\tBalance\tNote");
            foreach (var item in allTransactions)
            {
                balance += item.Amount;
                report.AppendLine($"{item.Date.ToShortDateString()}\t{item.Amount}\t{balance}\t{item.Notes}");
            }

            return report.ToString();
        }
    }
}
