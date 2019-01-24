import 'package:event_bus/event_bus.dart';

EventBus eventBus = new EventBus();

class TestEvent {
  String key;
  var value;

  TestEvent(this.key, this.value);
}
