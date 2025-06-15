class UserController {
  int id = 0;
  int chatId = 0;
  String username = 'Guest';
  int balance = 0;


    static final UserController instance = UserController._();
    UserController._();

    void updateFromJson(Map<String, dynamic> json) {
      id = json['id'] ?? 0;
      chatId = json['chat_id'] ?? 0;
      username = json['username'] ?? 'Guest';
      balance = json['balance'] ?? 0;
    }
  }
