import 'dart:convert';
import 'dart:io';

import 'package:stress_app/data/User.dart';
import 'package:path_provider/path_provider.dart';

class Json {
  static String dir;

  static Future<File> saveUser(User user) async {
    dir = '${(await getApplicationDocumentsDirectory()).path}/json_cache/';
    String path = '$dir${user.name}';
    return File(path)
        ..createSync(recursive: true)
        ..writeAsString(jsonEncode(user));
  }

  static Future<User> readUser(String name) async {
    dir = '${(await getApplicationDocumentsDirectory()).path}/json_cache/';
    File file = File('$dir$name');
    Map<String, dynamic> decoded = jsonDecode(file.readAsStringSync());
    return new User(
      decoded['name'],
      decoded['email'],
      decoded['homeOrder'].cast<int>(),
      decoded['musicList'].cast<String>(),
    );
  }
}