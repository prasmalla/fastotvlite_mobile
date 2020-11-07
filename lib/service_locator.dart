import 'package:flutter_common/package_manager.dart';
import 'package:flutter_common/runtime_device.dart';
import 'package:flutter_common/time_manager.dart';
import 'package:fastotvlite/events/search_events.dart';
import 'package:fastotvlite/events/stream_list_events.dart';
import 'package:fastotvlite/events/tv_events.dart';
import 'package:fastotvlite/shared_prefs.dart';
import 'package:get_it/get_it.dart';

// https://www.filledstacks.com/snippet/shared-preferences-service-in-flutter-for-code-maintainability/

GetIt locator = GetIt.instance;

Future setupLocator() async {
  var device = await RuntimeDevice.getInstance();
  locator.registerSingleton<RuntimeDevice>(device);

  var clientEvents = await StreamListEvent.getInstance();
  locator.registerSingleton<StreamListEvent>(clientEvents);

  var tvTabEvents = await TvTabsEvents.getInstance();
  locator.registerSingleton<TvTabsEvents>(tvTabEvents);

  var storage = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(storage);

  var package = await PackageManager.getInstance();
  locator.registerSingleton<PackageManager>(package);

  var time = await TimeManager.getInstance();
  locator.registerSingleton<TimeManager>(time);

  var searchEvents = await SearchEvents.getInstance();
  locator.registerSingleton<SearchEvents>(searchEvents);
}
