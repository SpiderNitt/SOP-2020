import 'dart:convert';

Map<String, dynamic> tryParseJwt(String token) {
dynamic parts = token.split('.');
dynamic payload = parts[1];
dynamic normalized = base64Url.normalize(payload);
dynamic resp = utf8.decode(base64Url.decode(normalized));
return json.decode(resp);
}