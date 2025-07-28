import 'dart:convert';
import 'dart:io';

import 'package:flutter_hentai_viewer/ehentai/gallery.dart';
import 'package:flutter_hentai_viewer/ehentai/stores/setting_store.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';

part 'history_store.g.dart';

HistoryStore historyStore = HistoryStore();

class HistoryStore = HistoryStoreBase with _$HistoryStore;

abstract class HistoryStoreBase with Store {
  @observable
  ObservableList<Gallery> historyGalleries = ObservableList<Gallery>();

  bool isInHistory(Gallery gallery) =>
      historyGalleries.any((e) => e.id == gallery.id);

  @action
  void add(Gallery gallery) {
    if (historyGalleries.any((e) => e.id == gallery.id)) {
      historyGalleries.removeWhere((e) => e.id == gallery.id);
    }
    historyGalleries.insert(0, gallery);
    while (historyGalleries.length > ehentaiSettingsStore.maxHistoryGalleries &&
        ehentaiSettingsStore.historyMode == HistoryMode.limited) {
      historyGalleries.removeLast();
    }
    save();
  }

  @action
  void remove(Gallery gallery) {
    historyGalleries.removeWhere((e) => e.id == gallery.id);
    save();
  }

  Future<void> read() async {
    final appDir = await getApplicationSupportDirectory();
    final file = File('${appDir.path}/ehentai_history.json');
    if (!file.existsSync()) {
      // init
      save();
    } else {
      historyGalleries = ObservableList<Gallery>.of(
        (json.decode(file.readAsStringSync()) as List<dynamic>)
            .map((e) => Gallery.fromJson(e as Map<String, dynamic>)),
      );
    }
  }

  Future<void> save() async {
    final appDir = await getApplicationSupportDirectory();
    final file = File('${appDir.path}/ehentai_history.json');
    file.writeAsStringSync(json.encode(historyGalleries));
  }
}
