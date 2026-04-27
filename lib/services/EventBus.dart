import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class ProductContentEvent {
  final String str;

  ProductContentEvent(this.str);
}

class LoginSuccessEvent {
  final String str;

  LoginSuccessEvent(this.str);
}
