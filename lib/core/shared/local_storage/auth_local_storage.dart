import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../di/injection_container.dart';

final storage = sl.get<FlutterSecureStorage>();

Future<void> saveUserId(String userId) async {
  await storage.write(key: 'userId', value: userId);
}

Future<String?> getUserId() async {
  final userId = await storage.read(key: 'userId');

  if (userId != null) {
    return userId;
  } else {
    return null;
  }
}

Future<void> deleteUserId() async {
  await storage.delete(key: 'userId');
}
