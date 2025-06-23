import 'dart:convert';
import 'dart:io';

import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';

part 'setting_store.g.dart';

SettingsStore nhentaiSettingsStore = SettingsStore();

class SettingsStore = SettingsStoreBase with _$SettingsStore;

abstract class SettingsStoreBase with Store {
  @observable
  bool autoUpdateTags = true;
  @action
  void setAutoUpdateTags(bool autoUpdateTags) {
    this.autoUpdateTags = autoUpdateTags;
    save();
  }

  Future<void> read() async {
    final appDir = await getApplicationSupportDirectory();
    final file = File('${appDir.path}/nhentai_settings.json');
    if (!file.existsSync()) {
      // init
      save();
    } else {
      final settings = json.decode(file.readAsStringSync());
      autoUpdateTags = settings['autoUpdateTags'] ?? true;
    }
  }

  Future<void> save() async {
    final appDir = await getApplicationSupportDirectory();
    final file = File('${appDir.path}/nhentai_settings.json');
    final settings = {
      'autoUpdateTags': autoUpdateTags,
    };
    file.writeAsStringSync(json.encode(settings));
  }
}
