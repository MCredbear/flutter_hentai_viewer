import 'dart:convert';
import 'dart:io';

import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';

part 'setting_store.g.dart';

SettingsStore nhentaiSettingsStore = SettingsStore();

class SettingsStore = SettingsStoreBase with _$SettingsStore;

enum HistoryMode {
  disabled,
  infinite,
  limited,
}

enum ShowHistoryMode {
  addAPin,
  doNotShow,
  showNormally,
}

enum ShowFavoriteMode {
  addAPin,
  showNormally,
}

abstract class SettingsStoreBase with Store {
  @observable
  bool autoUpdateTags = true;
  @action
  void setAutoUpdateTags(bool autoUpdateTags) {
    this.autoUpdateTags = autoUpdateTags;
    save();
  }

  @observable
  HistoryMode historyMode = HistoryMode.limited;
  @action
  void setHistoryState(HistoryMode state) {
    historyMode = state;
    save();
  }

  @observable
  int maxHistoryGalleries = 100;
  @action
  void setMaxHistoryGalleries(int max) {
    maxHistoryGalleries = max;
    save();
  }

  @observable
  ShowHistoryMode showHistoryMode = ShowHistoryMode.addAPin;
  @action
  void setShowHistoryState(ShowHistoryMode state) {
    showHistoryMode = state;
    save();
  }

  @observable
  ShowFavoriteMode showFavoriteMode = ShowFavoriteMode.addAPin;
  @action
  void setShowFavoriteState(ShowFavoriteMode state) {
    showFavoriteMode = state;
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
      historyMode = switch (settings['historyMode']) {
        'disabled' => HistoryMode.disabled,
        'infinite' => HistoryMode.infinite,
        'limited' => HistoryMode.limited,
        _ => HistoryMode.limited,
      };
      maxHistoryGalleries = settings['maxHistoryGalleries'] ?? 100;
      showHistoryMode = switch (settings['showHistoryMode']) {
        'addAPin' => ShowHistoryMode.addAPin,
        'doNotShow' => ShowHistoryMode.doNotShow,
        'showNormally' => ShowHistoryMode.showNormally,
        _ => ShowHistoryMode.addAPin,
      };
      showFavoriteMode = switch (settings['showFavoriteMode']) {
        'addAPin' => ShowFavoriteMode.addAPin,
        'showNormally' => ShowFavoriteMode.showNormally,
        _ => ShowFavoriteMode.addAPin,
      };
    }
  }

  Future<void> save() async {
    final appDir = await getApplicationSupportDirectory();
    final file = File('${appDir.path}/nhentai_settings.json');
    final settings = {
      'autoUpdateTags': autoUpdateTags,
      'historyMode': historyMode.name,
      'maxHistoryGalleries': maxHistoryGalleries,
      'showHistoryMode': showHistoryMode.name,
      'showFavoriteMode': showFavoriteMode.name,
    };
    file.writeAsStringSync(json.encode(settings));
  }
}
