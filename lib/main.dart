import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

// Files imported
import 'package:inductions_20/screens/views/splash/splash_screen.dart';
import 'package:inductions_20/screens/views/login/responsive_login_view.dart';
import 'package:inductions_20/screens/views/register/responsive_register_view.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (context) => LoginView(),
    ),
  );
}

//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return LayoutBuilder(
//      builder: (context, constraints) {
//        return OrientationBuilder(
//          builder: (context, orientation) {
//            return MaterialApp(
//              title: 'Inductions\'20',
//              home: RegisterScreen(),
//            );
//          },
//        );
//      },
//    );
//  }
//}

//class GraphQL extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    final HttpLink httpLink = HttpLink(uri: "");
//    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
//      GraphQLClient(
//        link: httpLink as Link,
//        cache: OptimisticCache(
//          dataIdFromObject: typenameDataIdFromObject,
//        ),
//      ),
//    );
//    return GraphQLProvider(
//      child: RegisterScreen(),
//      client: client,
//    );
//    return Container();
//  }
//}
