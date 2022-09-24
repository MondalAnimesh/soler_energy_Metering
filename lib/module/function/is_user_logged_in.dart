import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<bool> isUserLoggedIn() async {
  const storage = FlutterSecureStorage();
  String? token = await storage.read(key: "token");
  if (token == null) {
    return false;
  }
  return true;
}
