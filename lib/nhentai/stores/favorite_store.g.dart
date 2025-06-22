// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoriteStore on FavoriteStoreBase, Store {
  late final _$favoriteGalleriesAtom =
      Atom(name: 'FavoriteStoreBase.favoriteGalleries', context: context);

  @override
  ObservableList<Gallery> get favoriteGalleries {
    _$favoriteGalleriesAtom.reportRead();
    return super.favoriteGalleries;
  }

  @override
  set favoriteGalleries(ObservableList<Gallery> value) {
    _$favoriteGalleriesAtom.reportWrite(value, super.favoriteGalleries, () {
      super.favoriteGalleries = value;
    });
  }

  late final _$FavoriteStoreBaseActionController =
      ActionController(name: 'FavoriteStoreBase', context: context);

  @override
  void add(Gallery gallery) {
    final _$actionInfo = _$FavoriteStoreBaseActionController.startAction(
        name: 'FavoriteStoreBase.add');
    try {
      return super.add(gallery);
    } finally {
      _$FavoriteStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void remove(Gallery gallery) {
    final _$actionInfo = _$FavoriteStoreBaseActionController.startAction(
        name: 'FavoriteStoreBase.remove');
    try {
      return super.remove(gallery);
    } finally {
      _$FavoriteStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favoriteGalleries: ${favoriteGalleries}
    ''';
  }
}
