import 'package:args/command_runner.dart';
import 'package:translations_cleaner/src/sync_translations.dart';

class SyncTranslation extends Command {
  @override
  String get description => 'Sync other language files with en.json';

  @override
  String get name => 'sync-translations';

  @override
  void run() => syncTranslation();

}