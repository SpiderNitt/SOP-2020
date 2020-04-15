import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Files imported
import 'package:inductions_20/screens/enum/device_screen_type.dart';
import 'package:inductions_20/screens/ui/base_widget.dart';
import 'package:inductions_20/screens/views/login/mobile_login_view.dart';
import 'package:inductions_20/screens/views/login/largemobile_login_view.dart';
import 'package:inductions_20/screens/views/login/tablet_login_view.dart';
import 'package:inductions_20/screens/views/login/largetablet_login_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuild(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
          if (sizingInformation.orientation == Orientation.portrait) {
            return Login_Mobile_Portrait();
          } else {
            return Login_Mobile_Landscape();
          }
        } else if (sizingInformation.deviceScreenType ==
            DeviceScreenType.Tablet) {
          if (sizingInformation.orientation == Orientation.portrait) {
            return Login_Tablet_Portrait();
          } else {
            return Login_Tablet_Landscape();
          }
        } else if (sizingInformation.deviceScreenType ==
            DeviceScreenType.LargeMobile) {
          if (sizingInformation.orientation == Orientation.portrait) {
            return Login_Largemobile_Portrait();
          } else {
            return Login_Largemobile_Landscape();
          }
        } else {
          if (sizingInformation.orientation == Orientation.portrait) {
            return Login_Largetablet_Portrait();
          } else {
            return Login_Largetablet_Landscape();
          }
        }
      },
    );
  }
}
