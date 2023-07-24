import 'dart:io';

import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';

/// Get list of all `*.arb` files in the project
List<FileSystemEntity> translationFiles() {
  final path = Directory.current.path;

  final jsonFile = Glob("$path/assets/flutter-i18n/en.json");
  return jsonFile.listSync(followLinks: false);
}

List<FileSystemEntity> translationFilesExceptEn() {
  final path = Directory.current.path;

  final jsonFile = Glob("$path/assets/flutter-i18n/*.json");
  var list = jsonFile.listSync(followLinks: false);
  list.removeWhere((element) => element.path.contains('en.json'));
  return list;
}
