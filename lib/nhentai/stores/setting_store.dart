import 'dart:convert';
import 'dart:io';

import 'package:flutter_hentai_viewer/generated/l10n.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';

part 'setting_store.g.dart';

SettingsStore nhentaiSettingsStore = SettingsStore();

enum TitleType { english, japanese, all }

class SettingsStore = SettingsStoreBase with _$SettingsStore;

abstract class SettingsStoreBase with Store {
  @observable
  TitleType titleType = TitleType.all;
  @action
  void setTitleType(TitleType titleType) {
    this.titleType = titleType;
    save();
  }

  @computed
  String get titleTypeString {
    switch (nhentaiSettingsStore.titleType) {
      case TitleType.japanese:
        return L10n.current.japanese;
      case TitleType.english:
        return L10n.current.english;
      case TitleType.all:
        return L10n.current.all;
    }
  }

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
      titleType = switch (settings['titleType']) {
        'english' => TitleType.english,
        'japanese' => TitleType.japanese,
        'all' => TitleType.all,
        _ => TitleType.all,
      };
      autoUpdateTags = settings['autoUpdateTags'] ?? true;
    }
  }

  Future<void> save() async {
    final appDir = await getApplicationSupportDirectory();
    final file = File('${appDir.path}/nhentai_settings.json');
    final settings = {
      'titleType': titleType.name,
      'autoUpdateTags': autoUpdateTags,
    };
    file.writeAsStringSync(json.encode(settings));
  }
}
