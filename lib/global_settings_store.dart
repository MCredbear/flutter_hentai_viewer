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

enum ProxyMode {
  cloudflare,
  vercel,
  none,
}

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
  void setThemeData(ThemeData? themeData) {
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

  /// suit for @nekomoyi 's habit
  @observable
  bool scrollUpToLoadMore = false;
  @action
  void setScrollUpToLoadMore(bool scrollUpToLoadMore) {
    this.scrollUpToLoadMore = scrollUpToLoadMore;
    save();
  }

  @observable
  int preloadImageCount = 5;
  @action
  void setPreloadImageCount(int number) {
    preloadImageCount = number;
    save();
  }

  @observable
  String? source;
  @action
  void setSource(String? source) {
    this.source = source;
    save();
  }

  @observable
  Enum proxyMode = ProxyMode.vercel;
  @action
  void setProxyMode(ProxyMode mode) {
    proxyMode = mode;
    save();
  }

  Future<void> read() async {
    final appDir = await getApplicationSupportDirectory();
    final settingsFile = File('${appDir.path}/global_settings.json');
    if (!settingsFile.existsSync()) {
      // init
      save();
    } else {
      final settings = json.decode(settingsFile.readAsStringSync());
      locale = switch (settings['locale']) {
        null => null,
        _ => Locale(
            (settings['locale'] as String).substring(0, 2),
            (settings['locale'] as String).substring(3),
          ),
      };
      themeData = switch (settings['themeData']) {
        'Light' => ThemeData(brightness: Brightness.light, useMaterial3: false),
        'Dark' => ThemeData(brightness: Brightness.dark, useMaterial3: false),
        _ => null,
      };
      readingDirection = switch (settings['readingDirection']) {
        'ltr' => TextDirection.ltr,
        'rtl' => TextDirection.rtl,
        _ => TextDirection.ltr,
      };
      scrollUpToLoadMore = switch (settings['scrollUpToLoad']) {
        null => false,
        _ => settings['scrollUpToLoad'],
      };
      preloadImageCount = switch (settings['preloadImageCount']) {
        null => 5,
        _ => settings['preloadImageCount'],
      };
      source = switch (settings['source']) {
        null => null,
        _ => settings['source'] as String,
      };
      proxyMode = switch (settings['proxyMode']) {
        'cloudflare' => ProxyMode.cloudflare,
        'vercel' => ProxyMode.vercel,
        'none' => ProxyMode.none,
        _ => ProxyMode.vercel,
      };
    }
  }

  Future<void> save() async {
    final appDir = await getApplicationSupportDirectory();
    final settingsFile = File('${appDir.path}/global_settings.json');
    final settings = {
      'locale': (locale == null)
          ? null
          : '${locale!.languageCode}_${locale!.countryCode}',
      'themeData': switch (themeData) {
        ThemeData(brightness: Brightness.dark, useMaterial3: false) => 'Dark',
        ThemeData(brightness: Brightness.light, useMaterial3: false) => 'Light',
        _ => null,
      },
      'readingDirection': readingDirection.name,
      'scrollUpToLoad': scrollUpToLoadMore,
      'preloadImageCount': preloadImageCount,
      'source': source,
      'proxyMode': switch (proxyMode) {
        ProxyMode.cloudflare => 'cloudflare',
        ProxyMode.vercel => 'vercel',
        ProxyMode.none => 'none',
        _ => 'vercel',
      },
    };
    settingsFile.writeAsStringSync(json.encode(settings));
  }
}
