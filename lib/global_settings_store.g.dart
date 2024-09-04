// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GlobalSettingsStore on GlobalSettingsStoreBase, Store {
  Computed<String>? _$themeDataStringComputed;

  @override
  String get themeDataString => (_$themeDataStringComputed ??= Computed<String>(
          () => super.themeDataString,
          name: 'GlobalSettingsStoreBase.themeDataString'))
      .value;
  Computed<String>? _$readingDirectionStringComputed;

  @override
  String get readingDirectionString => (_$readingDirectionStringComputed ??=
          Computed<String>(() => super.readingDirectionString,
              name: 'GlobalSettingsStoreBase.readingDirectionString'))
      .value;

  late final _$localeAtom =
      Atom(name: 'GlobalSettingsStoreBase.locale', context: context);

  @override
  Locale? get locale {
    _$localeAtom.reportRead();
    return super.locale;
  }

  @override
  set locale(Locale? value) {
    _$localeAtom.reportWrite(value, super.locale, () {
      super.locale = value;
    });
  }

  late final _$themeDataAtom =
      Atom(name: 'GlobalSettingsStoreBase.themeData', context: context);

  @override
  ThemeData? get themeData {
    _$themeDataAtom.reportRead();
    return super.themeData;
  }

  @override
  set themeData(ThemeData? value) {
    _$themeDataAtom.reportWrite(value, super.themeData, () {
      super.themeData = value;
    });
  }

  late final _$readingDirectionAtom =
      Atom(name: 'GlobalSettingsStoreBase.readingDirection', context: context);

  @override
  TextDirection get readingDirection {
    _$readingDirectionAtom.reportRead();
    return super.readingDirection;
  }

  @override
  set readingDirection(TextDirection value) {
    _$readingDirectionAtom.reportWrite(value, super.readingDirection, () {
      super.readingDirection = value;
    });
  }

  late final _$GlobalSettingsStoreBaseActionController =
      ActionController(name: 'GlobalSettingsStoreBase', context: context);

  @override
  void setLocale(Locale? locale) {
    final _$actionInfo = _$GlobalSettingsStoreBaseActionController.startAction(
        name: 'GlobalSettingsStoreBase.setLocale');
    try {
      return super.setLocale(locale);
    } finally {
      _$GlobalSettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setThemeData(ThemeData themeData) {
    final _$actionInfo = _$GlobalSettingsStoreBaseActionController.startAction(
        name: 'GlobalSettingsStoreBase.setThemeData');
    try {
      return super.setThemeData(themeData);
    } finally {
      _$GlobalSettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setReadingDirection(TextDirection readingDirection) {
    final _$actionInfo = _$GlobalSettingsStoreBaseActionController.startAction(
        name: 'GlobalSettingsStoreBase.setReadingDirection');
    try {
      return super.setReadingDirection(readingDirection);
    } finally {
      _$GlobalSettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
locale: ${locale},
themeData: ${themeData},
readingDirection: ${readingDirection},
themeDataString: ${themeDataString},
readingDirectionString: ${readingDirectionString}
    ''';
  }
}
