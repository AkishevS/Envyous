class UserController {
  String username = 'Guest';
  double balance = 0.01;

  void updateBalance(double value) {
    balance += value;
  }
}
