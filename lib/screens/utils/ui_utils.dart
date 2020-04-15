import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:inductions_20/screens/enum/device_screen_type.dart';

DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
  var orientation = mediaQuery.orientation;
  double deviceWidth = 0;
  if (orientation == Orientation.landscape) {
    deviceWidth = mediaQuery.size.height;
  } else {
    deviceWidth = mediaQuery.size.width;
  }
  if (deviceWidth >= 900) {
    return DeviceScreenType.LargeTablet;
  } else if (deviceWidth >= 600) {
    return DeviceScreenType.Tablet;
  } else if (deviceWidth >= 400) {
    return DeviceScreenType.LargeMobile;
  }
  return DeviceScreenType.Mobile;
}
