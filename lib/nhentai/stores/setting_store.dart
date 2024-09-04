import 'dart:convert';
import 'dart:io';

import 'package:flutter_hentai_viewer/generated/l10n.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';

part 'setting_store.g.dart';

SettingsStore settingsStore = SettingsStore();

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
    switch (settingsStore.titleType) {
      case TitleType.japanese:
        return L10n.current.japanese;
      case TitleType.english:
        return L10n.current.english;
      case TitleType.all:
        return L10n.current.all;
    }
  }

  @observable
  int numberOfImageToPreload = 5;
  @action
  void setNumberOfImageToPreload(int number) {
    numberOfImageToPreload = number;
    save();
  }

  @observable
  String? customizedUserAgent;
  void setCustomizedUserAgent(String? userAgent) {
    customizedUserAgent = userAgent;
    save();
  }

  Future<void> read() async {
    final appDir = await getApplicationSupportDirectory();
    final file = File('${appDir.path}/nhentai_settings.json');
    if (!file.existsSync()) {
      // init
      save();
    } else {
      final settings =
          _Settings.fromJson(json.decode(file.readAsStringSync()));
      titleType = settings.titleType;
      numberOfImageToPreload = settings.numberOfImageToPreload;
      customizedUserAgent = settings.customizedUserAgent;
    }
  }

  Future<void> save() async {
    final appDir = await getApplicationSupportDirectory();
    final file = File('${appDir.path}/nhentai_settings.json');
    final settings =
        _Settings(titleType, numberOfImageToPreload, customizedUserAgent);
    file.writeAsStringSync(json.encode(settings.toJson()));
  }
}

@JsonSerializable()
class _Settings {
  _Settings(
      this.titleType, this.numberOfImageToPreload, this.customizedUserAgent);

  TitleType titleType = TitleType.all;

  int numberOfImageToPreload = 5;

  String? customizedUserAgent;

  factory _Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsToJson(this);
}
