import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/generated/l10n.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';

part 'global_settings_store.g.dart';

late BuildContext rootContext;

GlobalSettingsStore globalSettingsStore = GlobalSettingsStore();

class GlobalSettingsStore = GlobalSettingsStoreBase with _$GlobalSettingsStore;

abstract class GlobalSettingsStoreBase with Store {
  @observable
  Locale? locale;
  @action
  void setLocale(Locale? locale) {
    this.locale = locale;
    save();
  }

  @observable
  ThemeData? themeData;
  @action
  void setThemeData(ThemeData themeData) {
    this.themeData = themeData;
    save();
  }

  @computed
  String get themeDataString => (globalSettingsStore.themeData == null)
      ? ((MediaQuery.of(rootContext).platformBrightness == Brightness.dark)
          ? L10n.current.dark
          : L10n.current.light)
      : ((globalSettingsStore.themeData == ThemeData.dark(useMaterial3: false))
          ? L10n.current.dark
          : L10n.current.light);

  @observable
  TextDirection readingDirection = TextDirection.ltr;
  @action
  void setReadingDirection(TextDirection readingDirection) {
    this.readingDirection = readingDirection;
    save();
  }

  @computed
  String get readingDirectionString =>
      (globalSettingsStore.readingDirection == TextDirection.ltr)
          ? L10n.current.leftToRight
          : L10n.current.rightToLeft;

  Future<void> read() async {
    final appDir = await getApplicationSupportDirectory();
    final settingsFile = File('${appDir.path}/global_settings.json');
    if (!settingsFile.existsSync()) {
      // init
      save();
    } else {
      final settings = json.decode(settingsFile.readAsStringSync());
      locale = (settings['locale'] == null)
          ? null
          : Locale((settings['locale'] as String).substring(0, 2),
              (settings['locale'] as String).substring(3));
      themeData = ((settings['themeData'] == null)
          ? null
          : ((settings['themeData'] as String).startsWith('Dark'))
              ? ThemeData.dark(useMaterial3: false)
              : ThemeData.light(useMaterial3: false));
      readingDirection = ((settings['readingDirection'] as String)
              .startsWith(TextDirection.ltr.name))
          ? TextDirection.ltr
          : TextDirection.rtl;
    }
  }

  Future<void> save() async {
    final appDir = await getApplicationSupportDirectory();
    final settingsFile = File('${appDir.path}/global_settings.json');
    final settings = {
      'locale': (locale == null)
          ? null
          : '${locale!.languageCode}_${locale!.countryCode}',
      'themeData': (themeData == null)
          ? ThemeData.dark(useMaterial3: false)
          : (themeData == ThemeData.dark(useMaterial3: false))
              ? 'Dark'
              : 'Light',
      'readingDirection': readingDirection.name
    };
    settingsFile.writeAsStringSync(json.encode(settings));
  }
}
