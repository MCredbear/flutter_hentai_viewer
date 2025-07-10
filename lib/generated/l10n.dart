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

  /// `Downloaded`
  String get downloaded {
    return Intl.message(
      'Downloaded',
      name: 'downloaded',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get favorite {
    return Intl.message(
      'Favorite',
      name: 'favorite',
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

  /// `Depends on system`
  String get dependsOnSystem {
    return Intl.message(
      'Depends on system',
      name: 'dependsOnSystem',
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

  /// `Jump to`
  String get jumpTo {
    return Intl.message(
      'Jump to',
      name: 'jumpTo',
      desc: '',
      args: [],
    );
  }

  /// `Jump`
  String get jump {
    return Intl.message(
      'Jump',
      name: 'jump',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Network error`
  String get networkError {
    return Intl.message(
      'Network error',
      name: 'networkError',
      desc: '',
      args: [],
    );
  }

  /// `Update tags`
  String get updateTags {
    return Intl.message(
      'Update tags',
      name: 'updateTags',
      desc: '',
      args: [],
    );
  }

  /// `Scroll up to load more (infinite scroll)`
  String get scrollUpToLoadMore {
    return Intl.message(
      'Scroll up to load more (infinite scroll)',
      name: 'scrollUpToLoadMore',
      desc: '',
      args: [],
    );
  }

  /// `Preload image count`
  String get preloadImageCount {
    return Intl.message(
      'Preload image count',
      name: 'preloadImageCount',
      desc: '',
      args: [],
    );
  }

  /// `Auto update tags`
  String get autoUpdateTags {
    return Intl.message(
      'Auto update tags',
      name: 'autoUpdateTags',
      desc: '',
      args: [],
    );
  }

  /// `Pages`
  String get pageCount {
    return Intl.message(
      'Pages',
      name: 'pageCount',
      desc: '',
      args: [],
    );
  }

  /// `Switch source`
  String get switchSource {
    return Intl.message(
      'Switch source',
      name: 'switchSource',
      desc: '',
      args: [],
    );
  }

  /// `Select domain`
  String get selectDomain {
    return Intl.message(
      'Select domain',
      name: 'selectDomain',
      desc: '',
      args: [],
    );
  }

  /// `Test speed`
  String get testSpeed {
    return Intl.message(
      'Test speed',
      name: 'testSpeed',
      desc: '',
      args: [],
    );
  }

  /// `Latency`
  String get latency {
    return Intl.message(
      'Latency',
      name: 'latency',
      desc: '',
      args: [],
    );
  }

  /// `Unreachable`
  String get unreachable {
    return Intl.message(
      'Unreachable',
      name: 'unreachable',
      desc: '',
      args: [],
    );
  }

  /// `History mode`
  String get historyMode {
    return Intl.message(
      'History mode',
      name: 'historyMode',
      desc: '',
      args: [],
    );
  }

  /// `Disabled`
  String get disabled {
    return Intl.message(
      'Disabled',
      name: 'disabled',
      desc: '',
      args: [],
    );
  }

  /// `Infinite`
  String get infinite {
    return Intl.message(
      'Infinite',
      name: 'infinite',
      desc: '',
      args: [],
    );
  }

  /// `Limited`
  String get limited {
    return Intl.message(
      'Limited',
      name: 'limited',
      desc: '',
      args: [],
    );
  }

  /// `History limit`
  String get historyLimit {
    return Intl.message(
      'History limit',
      name: 'historyLimit',
      desc: '',
      args: [],
    );
  }

  /// `Show history mode`
  String get showHistoryMode {
    return Intl.message(
      'Show history mode',
      name: 'showHistoryMode',
      desc: '',
      args: [],
    );
  }

  /// `Add a pin on history gallery cover`
  String get addAPin {
    return Intl.message(
      'Add a pin on history gallery cover',
      name: 'addAPin',
      desc: '',
      args: [],
    );
  }

  /// `Do not show history gallery`
  String get doNotShow {
    return Intl.message(
      'Do not show history gallery',
      name: 'doNotShow',
      desc: '',
      args: [],
    );
  }

  /// `No more else process`
  String get showNormally {
    return Intl.message(
      'No more else process',
      name: 'showNormally',
      desc: '',
      args: [],
    );
  }

  /// `Show favorite mode`
  String get showFavoriteMode {
    return Intl.message(
      'Show favorite mode',
      name: 'showFavoriteMode',
      desc: '',
      args: [],
    );
  }

  /// `Proxy mode`
  String get proxyMode {
    return Intl.message(
      'Proxy mode',
      name: 'proxyMode',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get none {
    return Intl.message(
      'None',
      name: 'none',
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
