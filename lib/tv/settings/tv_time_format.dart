import 'package:fastotvlite/events/tv_events.dart';
import 'package:fastotvlite/localization/app_localizations.dart';
import 'package:fastotvlite/service_locator.dart';
import 'package:fastotvlite/shared_prefs.dart';
import 'package:fastotvlite/tv/settings/tv_settings_page.dart';
import 'package:fastotv_common/colors.dart';
import 'package:fastotv_common/tv/key_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClockFormatPickerTV extends StatefulWidget {
  final FocusNode focus;
  final void Function() callback;

  ClockFormatPickerTV(this.focus, this.callback);

  @override
  _ClockFormatPickerTVState createState() {
    return _ClockFormatPickerTVState();
  }
}

class _ClockFormatPickerTVState extends State<ClockFormatPickerTV> {
  int _currentSelection = 0;

  @override
  Widget build(BuildContext context) {
    return Focus(
        canRequestFocus: false,
        child: Container(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _dialogItem('13:00', 0),
                  _dialogItem('1:00 PM', 1)
                ])));
  }

  Widget _dialogItem(String text, int itemvalue) {
    return Focus(
        onKey: _listControl,
        focusNode: widget.focus,
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: borderColor(itemvalue == _currentSelection && widget.focus.hasPrimaryFocus), width: 2)),
            child: RadioListTile(
                activeColor: CustomColor().tvSelectedColor(),
                title: Text(text, style: TextStyle(fontSize: 20)),
                value: itemvalue,
                groupValue: _currentSelection,
                onChanged: _changeFormat)));
  }

  void _changeFormat(int value) async {
    _currentSelection = value;
    bool is24 = value == 0;
    final settings = locator<LocalStorageService>();
    settings.setTimeFormat(is24);
    final tvTabsEvents = locator<TvTabsEvents>();
    tvTabsEvents.publish(ClockFormatChanged(is24));
    setState(() {});
  }

  bool _listControl(FocusNode node, RawKeyEvent event) {
    if (event is RawKeyDownEvent && event.data is RawKeyEventDataAndroid) {
      RawKeyDownEvent rawKeyDownEvent = event;
      RawKeyEventDataAndroid rawKeyEventDataAndroid = rawKeyDownEvent.data;
      switch (rawKeyEventDataAndroid.keyCode) {
        case KEY_UP:
          _prevCategory();
          break;
        case KEY_DOWN:
          _nextCategory();
          break;
        case KEY_LEFT:
          FocusScope.of(context).focusInDirection(TraversalDirection.left);
          widget.callback();
          break;
        default:
      }
    }
    return widget.focus.hasPrimaryFocus;
  }

  void _nextCategory() {
    if (_currentSelection == SUPPORTED_LOCALES.length - 1) {
      _currentSelection = 0;
    } else {
      _currentSelection++;
    }
    _changeFormat(_currentSelection);
  }

  void _prevCategory() {
    if (_currentSelection == 0) {
      _currentSelection = SUPPORTED_LOCALES.length - 1;
    } else {
      _currentSelection--;
    }
    _changeFormat(_currentSelection);
  }
}
