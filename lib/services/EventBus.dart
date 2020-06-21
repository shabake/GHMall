import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class ProductContentEvent {
  String str;

  ProductContentEvent(String str) {
    this.str = str;
  }
}


class LoginSuccessEvent {
  String str;

  LoginSuccessEvent(String str) {
    this.str = str;
  }
}
