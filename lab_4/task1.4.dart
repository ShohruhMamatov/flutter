class BankAccount {
  String accountNumber;
  String accountHolderName;
  double balance;

  BankAccount(this.accountNumber, this.accountHolderName, this.balance);

  void deposit(double amount) {
    if (amount <= 0) {
      print('Deposit amount must be positive.');
      return;
    }
    balance += amount;
    print('Deposited \$${amount.toStringAsFixed(2)}. New balance: \$${balance.toStringAsFixed(2)}');
  }

  void withdraw(double amount) {
    if (amount <= 0) {
      print('Withdrawal amount must be positive.');
      return;
    }
    if (amount > balance) {
      print('Error: Insufficient funds. Withdrawal denied.');
    } else {
      balance -= amount;
      print('Withdrew \$${amount.toStringAsFixed(2)}. New balance: \$${balance.toStringAsFixed(2)}');
    }
  }
}
