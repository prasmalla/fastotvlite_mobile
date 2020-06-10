import 'package:event_bus/event_bus.dart';
import 'package:fastotvlite/channels/istream.dart';

class TvTabsEvents {
  static Future<TvTabsEvents> getInstance() async {
    if (_instance == null) {
      _instance = TvTabsEvents();
    }
    return _instance;
  }

  void publish(dynamic event) {
    _bus.fire(event);
  }

  Stream<T> subscribe<T>() {
    return _bus.on<T>();
  }

  // private:
  static TvTabsEvents _instance;
  final _bus = EventBus(sync: true);
}

class OpenedTvSettings {
  final bool value;

  OpenedTvSettings(this.value);
}

class ClockFormatChanged {
  final bool hour24;

  ClockFormatChanged(this.hour24);
}

class TvSearchEvent {
  final IStream stream;

  TvSearchEvent(this.stream);
}