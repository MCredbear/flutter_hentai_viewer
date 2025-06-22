import 'dart:convert';
import 'dart:io';

import 'package:flutter_hentai_viewer/nhentai/gallery.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';

part 'favorite_store.g.dart';

FavoriteStore favoriteStore = FavoriteStore();

class FavoriteStore = FavoriteStoreBase with _$FavoriteStore;

abstract class FavoriteStoreBase with Store {
  @observable
  ObservableList<Gallery> favoriteGalleries = ObservableList<Gallery>();

  bool isFavorite(Gallery gallery) =>
      favoriteGalleries.any((e) => e.id == gallery.id);

  @action
  void add(Gallery gallery) {
    if (isFavorite(gallery)) {
      return;
    }
    favoriteGalleries.add(gallery);
  }

  @action
  void remove(Gallery gallery) {
    favoriteGalleries.removeWhere((e) => e.id == gallery.id);
  }

  Future<void> read() async {
    final appDir = await getApplicationSupportDirectory();
    final file = File('${appDir.path}/nhentai_favorite.json');
    if (!file.existsSync()) {
      // init
      save();
    } else {
      favoriteGalleries = ObservableList<Gallery>.of(
        (json.decode(file.readAsStringSync()) as List<dynamic>)
            .map((e) => Gallery.fromJson(e as Map<String, dynamic>)),
      );
    }
  }

  Future<void> save() async {
    final appDir = await getApplicationSupportDirectory();
    final file = File('${appDir.path}/nhentai_favorite.json');
    file.writeAsStringSync(json.encode(favoriteGalleries));
  }
}
