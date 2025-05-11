// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsStore on SettingsStoreBase, Store {
  Computed<String>? _$titleTypeStringComputed;

  @override
  String get titleTypeString => (_$titleTypeStringComputed ??= Computed<String>(
          () => super.titleTypeString,
          name: 'SettingsStoreBase.titleTypeString'))
      .value;

  late final _$titleTypeAtom =
      Atom(name: 'SettingsStoreBase.titleType', context: context);

  @override
  TitleType get titleType {
    _$titleTypeAtom.reportRead();
    return super.titleType;
  }

  @override
  set titleType(TitleType value) {
    _$titleTypeAtom.reportWrite(value, super.titleType, () {
      super.titleType = value;
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

  late final _$SettingsStoreBaseActionController =
      ActionController(name: 'SettingsStoreBase', context: context);

  @override
  void setTitleType(TitleType titleType) {
    final _$actionInfo = _$SettingsStoreBaseActionController.startAction(
        name: 'SettingsStoreBase.setTitleType');
    try {
      return super.setTitleType(titleType);
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
  String toString() {
    return '''
titleType: ${titleType},
autoUpdateTags: ${autoUpdateTags},
titleTypeString: ${titleTypeString}
    ''';
  }
}
