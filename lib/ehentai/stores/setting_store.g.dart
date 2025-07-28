// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsStore on SettingsStoreBase, Store {
  late final _$enabledCategoriesAtom =
      Atom(name: 'SettingsStoreBase.enabledCategories', context: context);

  @override
  ObservableList<Category> get enabledCategories {
    _$enabledCategoriesAtom.reportRead();
    return super.enabledCategories;
  }

  @override
  set enabledCategories(ObservableList<Category> value) {
    _$enabledCategoriesAtom.reportWrite(value, super.enabledCategories, () {
      super.enabledCategories = value;
    });
  }

  late final _$autoUpdateTagsAtom =
      Atom(name: 'SettingsStoreBase.autoUpdateTags', context: context);

  @override
  bool get autoUpdateTags {
    _$autoUpdateTagsAtom.reportRead();
    return super.autoUpdateTags;
  }

  @override
  set autoUpdateTags(bool value) {
    _$autoUpdateTagsAtom.reportWrite(value, super.autoUpdateTags, () {
      super.autoUpdateTags = value;
    });
  }

  late final _$historyModeAtom =
      Atom(name: 'SettingsStoreBase.historyMode', context: context);

  @override
  HistoryMode get historyMode {
    _$historyModeAtom.reportRead();
    return super.historyMode;
  }

  @override
  set historyMode(HistoryMode value) {
    _$historyModeAtom.reportWrite(value, super.historyMode, () {
      super.historyMode = value;
    });
  }

  late final _$maxHistoryGalleriesAtom =
      Atom(name: 'SettingsStoreBase.maxHistoryGalleries', context: context);

  @override
  int get maxHistoryGalleries {
    _$maxHistoryGalleriesAtom.reportRead();
    return super.maxHistoryGalleries;
  }

  @override
  set maxHistoryGalleries(int value) {
    _$maxHistoryGalleriesAtom.reportWrite(value, super.maxHistoryGalleries, () {
      super.maxHistoryGalleries = value;
    });
  }

  late final _$showHistoryModeAtom =
      Atom(name: 'SettingsStoreBase.showHistoryMode', context: context);

  @override
  ShowHistoryMode get showHistoryMode {
    _$showHistoryModeAtom.reportRead();
    return super.showHistoryMode;
  }

  @override
  set showHistoryMode(ShowHistoryMode value) {
    _$showHistoryModeAtom.reportWrite(value, super.showHistoryMode, () {
      super.showHistoryMode = value;
    });
  }

  late final _$showFavoriteModeAtom =
      Atom(name: 'SettingsStoreBase.showFavoriteMode', context: context);

  @override
  ShowFavoriteMode get showFavoriteMode {
    _$showFavoriteModeAtom.reportRead();
    return super.showFavoriteMode;
  }

  @override
  set showFavoriteMode(ShowFavoriteMode value) {
    _$showFavoriteModeAtom.reportWrite(value, super.showFavoriteMode, () {
      super.showFavoriteMode = value;
    });
  }

  late final _$SettingsStoreBaseActionController =
      ActionController(name: 'SettingsStoreBase', context: context);

  @override
  void setEnabledCategory(Category category, bool value) {
    final _$actionInfo = _$SettingsStoreBaseActionController.startAction(
        name: 'SettingsStoreBase.setEnabledCategory');
    try {
      return super.setEnabledCategory(category, value);
    } finally {
      _$SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAutoUpdateTags(bool autoUpdateTags) {
    final _$actionInfo = _$SettingsStoreBaseActionController.startAction(
        name: 'SettingsStoreBase.setAutoUpdateTags');
    try {
      return super.setAutoUpdateTags(autoUpdateTags);
    } finally {
      _$SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHistoryState(HistoryMode state) {
    final _$actionInfo = _$SettingsStoreBaseActionController.startAction(
        name: 'SettingsStoreBase.setHistoryState');
    try {
      return super.setHistoryState(state);
    } finally {
      _$SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMaxHistoryGalleries(int max) {
    final _$actionInfo = _$SettingsStoreBaseActionController.startAction(
        name: 'SettingsStoreBase.setMaxHistoryGalleries');
    try {
      return super.setMaxHistoryGalleries(max);
    } finally {
      _$SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setShowHistoryState(ShowHistoryMode state) {
    final _$actionInfo = _$SettingsStoreBaseActionController.startAction(
        name: 'SettingsStoreBase.setShowHistoryState');
    try {
      return super.setShowHistoryState(state);
    } finally {
      _$SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setShowFavoriteState(ShowFavoriteMode state) {
    final _$actionInfo = _$SettingsStoreBaseActionController.startAction(
        name: 'SettingsStoreBase.setShowFavoriteState');
    try {
      return super.setShowFavoriteState(state);
    } finally {
      _$SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
enabledCategories: ${enabledCategories},
autoUpdateTags: ${autoUpdateTags},
historyMode: ${historyMode},
maxHistoryGalleries: ${maxHistoryGalleries},
showHistoryMode: ${showHistoryMode},
showFavoriteMode: ${showFavoriteMode}
    ''';
  }
}
