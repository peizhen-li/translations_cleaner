import 'package:args/command_runner.dart';

import 'commands/clean_translation.dart';
import 'commands/list_unused_translations.dart';
import 'commands/sync_translation.dart';

void main(List<String> arguments) {
  CommandRunner(
      'dart pub run translations_cleaner',
      'Dart package to clean unused '
          'translations from the arb files')
    ..addCommand(CleanTranslation())
    ..addCommand(ListUnusedTranslations())
    ..addCommand(SyncTranslation())
    ..run(arguments);
}
