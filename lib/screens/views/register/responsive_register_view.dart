import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Files imported
import 'package:inductions_20/screens/enum/device_screen_type.dart';
import 'package:inductions_20/screens/ui/base_widget.dart';
import 'package:inductions_20/screens/views/register/mobile_register_view.dart';
import 'package:inductions_20/screens/views/register/large_mobile_register.dart';
import 'package:inductions_20/screens/views/register/tablet_register_view.dart';
import 'package:inductions_20/screens/views/register/large_tablet_register.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuild(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
          if (sizingInformation.orientation == Orientation.portrait) {
            return Register_Mobile_Portrait();
          } else {
            return Register_Mobile_Landscape();
          }
        } else if (sizingInformation.deviceScreenType ==
            DeviceScreenType.LargeMobile) {
          if (sizingInformation.orientation == Orientation.portrait) {
            return Register_Largemobile_Portrait();
          } else {
            return Register_Largemobile_Landscape();
          }
        } else if (sizingInformation.deviceScreenType ==
            DeviceScreenType.Tablet) {
          if (sizingInformation.orientation == Orientation.portrait) {
            return Register_Tablet_Portrait();
          } else {
            return Register_Tablet_Landscape();
          }
        } else {
          if (sizingInformation.orientation == Orientation.portrait) {
            return Register_Largetablet_Portrait();
          } else {
            return Register_Largetablet_Landscape();
          }
        }
      },
    );
  }
}
