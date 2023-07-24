import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:translations_cleaner/src/translation_files.dart';

Future<void> syncTranslation() async {

  final files = translationFilesExceptEn();

  await Future.wait(files.map((file) => _syncFile(file)));
}

Future<void> _syncFile(FileSystemEntity otherFile) async {
  final path = Directory.current.path;

  final enString =
      await File("$path/assets/flutter-i18n/en.json").readAsString();
  final Map<String, dynamic> enJson = jsonDecode(enString);

  final otherString = await File(otherFile.path).readAsString();
  final Map<String, dynamic> otherJson = jsonDecode(otherString);
  var finalJson = <String, dynamic>{};
  for (var key in enJson.keys) {
    if (otherJson.containsKey(key)) {
      finalJson[key] = otherJson[key];
    } else {
      finalJson[key] = enJson[key];
    }
  }

  await File(otherFile.path)
      .writeAsString(JsonEncoder.withIndent(' ' * 2).convert(finalJson));
  print('Synced ${p.basename(otherFile.path)} with en.json 💪 🚀');
}
