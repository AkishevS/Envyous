@JS('Telegram.WebApp')
library telegram;

import 'package:js/js.dart';

@JS()
external InitData get initData;

@JS()
class InitData {
  external String get initData;
  external InitDataUnsafe get initDataUnsafe;
}

@JS()
class InitDataUnsafe {
  external TelegramUser get user;
  external String get start_param;
}

@JS()
class TelegramUser {
  external int get id;
  external String get first_name;
  external String? get username;
}
