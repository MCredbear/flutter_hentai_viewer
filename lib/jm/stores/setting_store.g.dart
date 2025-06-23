// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsStore on SettingsStoreBase, Store {
  late final _$domainAtom =
      Atom(name: 'SettingsStoreBase.domain', context: context);

  @override
  String? get domain {
    _$domainAtom.reportRead();
    return super.domain;
  }

  @override
  set domain(String? value) {
    _$domainAtom.reportWrite(value, super.domain, () {
      super.domain = value;
    });
  }

  late final _$domain2latencyAtom =
      Atom(name: 'SettingsStoreBase.domain2latency', context: context);

  @override
  ObservableMap<String, int?> get domain2latency {
    _$domain2latencyAtom.reportRead();
    return super.domain2latency;
  }

  @override
  set domain2latency(ObservableMap<String, int?> value) {
    _$domain2latencyAtom.reportWrite(value, super.domain2latency, () {
      super.domain2latency = value;
    });
  }

  late final _$SettingsStoreBaseActionController =
      ActionController(name: 'SettingsStoreBase', context: context);

  @override
  void setDomain(String? domain) {
    final _$actionInfo = _$SettingsStoreBaseActionController.startAction(
        name: 'SettingsStoreBase.setDomain');
    try {
      return super.setDomain(domain);
    } finally {
      _$SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDomainLatency(String domain, int? latency) {
    final _$actionInfo = _$SettingsStoreBaseActionController.startAction(
        name: 'SettingsStoreBase.setDomainLatency');
    try {
      return super.setDomainLatency(domain, latency);
    } finally {
      _$SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
domain: ${domain},
domain2latency: ${domain2latency}
    ''';
  }
}
