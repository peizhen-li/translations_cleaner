import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:translations_cleaner/src/export_unused_terms.dart';
import 'package:translations_cleaner/src/models/term.dart';
import 'package:translations_cleaner/src/translation_files.dart';
import 'package:translations_cleaner/src/unused_terms.dart';

/// Delete unused terms from the dart files
Future<void> deleteTerms(ArgResults? argResults) async {
  final bool exportTerms = argResults?['export'];
  final String? outputPath = argResults?['output-path'];

  final files = translationFiles();
  final terms = findUnusedTerms();

  if (terms.isNotEmpty && exportTerms) {
    exportUnusedTerms(terms, outputPath);
  }
  await Future.wait(files.map((file) => _deleteTermsForFile(file, terms)));
  print('${terms.length} terms removed from ${files.length} files each 💪 🚀');
}

Future<void> _deleteTermsForFile(
    FileSystemEntity jsonFile, Set<Term> terms) async {
  final fileString = await File(jsonFile.path).readAsString();
  final Map<String, dynamic> json = jsonDecode(fileString);
  for (var term in terms) {
    json.remove(term.key);
    if (term.additionalAttributes) {
      json.remove('@${term.key}');
    }
  }
  // Indent is being used for proper formatting
  await File(jsonFile.path)
      .writeAsString(JsonEncoder.withIndent(' ' * 2).convert(json));
}
