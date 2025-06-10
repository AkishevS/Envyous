import 'dart:js' as js;

class TelegramService {
  static dynamic get _webApp => js.context['Telegram']?['WebApp'];

  static String get chatId => _webApp?['initDataUnsafe']?['user']?['id']?.toString() ?? '';
  static String get username => _webApp?['initDataUnsafe']?['user']?['username'] ?? '';
}
