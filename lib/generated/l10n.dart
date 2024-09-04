// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class L10n {
  L10n();

  static L10n? _current;

  static L10n get current {
    assert(_current != null,
        'No instance of L10n was loaded. Try to initialize the L10n delegate before accessing L10n.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<L10n> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = L10n();
      L10n._current = instance;

      return instance;
    });
  }

  static L10n of(BuildContext context) {
    final instance = L10n.maybeOf(context);
    assert(instance != null,
        'No instance of L10n present in the widget tree. Did you add L10n.delegate in localizationsDelegates?');
    return instance!;
  }

  static L10n? maybeOf(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  /// `Downloaded galleries`
  String get downloadedGalleries {
    return Intl.message(
      'Downloaded galleries',
      name: 'downloadedGalleries',
      desc: '',
      args: [],
    );
  }

  /// `Favorite galleries`
  String get favoriteGalleries {
    return Intl.message(
      'Favorite galleries',
      name: 'favoriteGalleries',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Tag filter`
  String get tagFilter {
    return Intl.message(
      'Tag filter',
      name: 'tagFilter',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get thisLanguage {
    return Intl.message(
      'English',
      name: 'thisLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Reading direction`
  String get readingDirection {
    return Intl.message(
      'Reading direction',
      name: 'readingDirection',
      desc: '',
      args: [],
    );
  }

  /// `Left to right`
  String get leftToRight {
    return Intl.message(
      'Left to right',
      name: 'leftToRight',
      desc: '',
      args: [],
    );
  }

  /// `Right to left`
  String get rightToLeft {
    return Intl.message(
      'Right to left',
      name: 'rightToLeft',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Global type`
  String get global {
    return Intl.message(
      'Global type',
      name: 'global',
      desc: '',
      args: [],
    );
  }

  /// `Title style`
  String get titleStyle {
    return Intl.message(
      'Title style',
      name: 'titleStyle',
      desc: '',
      args: [],
    );
  }

  /// `Japanese`
  String get japanese {
    return Intl.message(
      'Japanese',
      name: 'japanese',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Number of image to preload`
  String get numberOfImageToPreload {
    return Intl.message(
      'Number of image to preload',
      name: 'numberOfImageToPreload',
      desc: '',
      args: [],
    );
  }

  /// `Customize User-Agent`
  String get customizeUserAgent {
    return Intl.message(
      'Customize User-Agent',
      name: 'customizeUserAgent',
      desc: '',
      args: [],
    );
  }

  /// `Enabled tag`
  String get enabledTag {
    return Intl.message(
      'Enabled tag',
      name: 'enabledTag',
      desc: '',
      args: [],
    );
  }

  /// `Tag`
  String get tag {
    return Intl.message(
      'Tag',
      name: 'tag',
      desc: '',
      args: [],
    );
  }

  /// `Artist`
  String get artist {
    return Intl.message(
      'Artist',
      name: 'artist',
      desc: '',
      args: [],
    );
  }

  /// `Character`
  String get character {
    return Intl.message(
      'Character',
      name: 'character',
      desc: '',
      args: [],
    );
  }

  /// `Parody`
  String get parody {
    return Intl.message(
      'Parody',
      name: 'parody',
      desc: '',
      args: [],
    );
  }

  /// `Group`
  String get group {
    return Intl.message(
      'Group',
      name: 'group',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<L10n> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
      Locale.fromSubtags(languageCode: 'ja', countryCode: 'JP'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<L10n> load(Locale locale) => L10n.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
