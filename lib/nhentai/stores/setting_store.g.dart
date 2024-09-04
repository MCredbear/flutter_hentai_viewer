// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
      $enumDecode(_$TitleTypeEnumMap, json['titleType']),
      (json['numberOfImageToPreload'] as num).toInt(),
      json['customizedUserAgent'] as String?,
    );

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
      'titleType': _$TitleTypeEnumMap[instance.titleType]!,
      'numberOfImageToPreload': instance.numberOfImageToPreload,
      'customizedUserAgent': instance.customizedUserAgent,
    };

const _$TitleTypeEnumMap = {
  TitleType.english: 'english',
  TitleType.japanese: 'japanese',
  TitleType.all: 'all',
};

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

  late final _$numberOfImageToPreloadAtom =
      Atom(name: 'SettingsStoreBase.numberOfImageToPreload', context: context);

  @override
  int get numberOfImageToPreload {
    _$numberOfImageToPreloadAtom.reportRead();
    return super.numberOfImageToPreload;
  }

  @override
  set numberOfImageToPreload(int value) {
    _$numberOfImageToPreloadAtom
        .reportWrite(value, super.numberOfImageToPreload, () {
      super.numberOfImageToPreload = value;
    });
  }

  late final _$customizedUserAgentAtom =
      Atom(name: 'SettingsStoreBase.customizedUserAgent', context: context);

  @override
  String? get customizedUserAgent {
    _$customizedUserAgentAtom.reportRead();
    return super.customizedUserAgent;
  }

  @override
  set customizedUserAgent(String? value) {
    _$customizedUserAgentAtom.reportWrite(value, super.customizedUserAgent, () {
      super.customizedUserAgent = value;
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
  void setNumberOfImageToPreload(int number) {
    final _$actionInfo = _$SettingsStoreBaseActionController.startAction(
        name: 'SettingsStoreBase.setNumberOfImageToPreload');
    try {
      return super.setNumberOfImageToPreload(number);
    } finally {
      _$SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
titleType: ${titleType},
numberOfImageToPreload: ${numberOfImageToPreload},
customizedUserAgent: ${customizedUserAgent},
titleTypeString: ${titleTypeString}
    ''';
  }
}
