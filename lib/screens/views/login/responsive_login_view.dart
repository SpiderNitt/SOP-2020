import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Files imported
import 'package:inductions_20/screens/enum/device_screen_type.dart';
import 'package:inductions_20/screens/ui/base_widget.dart';
import 'package:inductions_20/screens/views/login/mobile_login_view.dart';
import 'package:inductions_20/screens/views/login/tablet_login_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuild(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
          return Loginview();
        } else if (sizingInformation.deviceScreenType ==
            DeviceScreenType.LargeMobile) {
          return Loginview();
        } else if (sizingInformation.deviceScreenType ==
            DeviceScreenType.Tablet) {
          return Logintablet();
        } else {
          return Logintablet();
        }
      },
    );
  }
}
