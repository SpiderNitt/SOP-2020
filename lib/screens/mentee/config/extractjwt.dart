import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProvideJwt {
  String jwt;
  ProvideJwt();
  Future<void> extractjwt() async {
    final storage = new FlutterSecureStorage();
    this.jwt = await storage.read(key: "jwt");
  }
}

ProvideJwt provideJwt = ProvideJwt();
