import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
class ProvideJwt {
  String jwt;
  ProvideJwt() 
  {
  
    this.jwt= extractjwt();
    final decoded_jwt = base64.decode(jwt);
    print(decoded_jwt);

  }
  
  extractjwt() async{
  final storage = new FlutterSecureStorage();
  this.jwt= await storage.read(key:"jwt");
   return this.jwt;
  }

}

ProvideJwt provideJwt = ProvideJwt();
