// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsStore on SettingsStoreBase, Store {
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

  late final _$SettingsStoreBaseActionController =
      ActionController(name: 'SettingsStoreBase', context: context);

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
  String toString() {
    return '''
autoUpdateTags: ${autoUpdateTags}
    ''';
  }
}
