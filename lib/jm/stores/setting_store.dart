import 'dart:convert';
import 'dart:io';

import 'package:flutter_hentai_viewer/jm/utils.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';

part 'setting_store.g.dart';

SettingsStore jmSettingsStore = SettingsStore();

class SettingsStore = SettingsStoreBase with _$SettingsStore;

abstract class SettingsStoreBase with Store {
  @observable
  String? domain;
  @action
  void setDomain(String? domain) {
    this.domain = domain;
    save();
  }

  @observable
  ObservableMap<String, int?> domain2latency =
      ObservableMap.of({for (var domain in domains) domain: null});
  @action
  void setDomainLatency(String domain, int? latency) {
    domain2latency[domain] = latency;
  }

  Future<void> read() async {
    final appDir = await getApplicationSupportDirectory();
    final file = File('${appDir.path}/jm_settings.json');
    if (!file.existsSync()) {
      // init
      save();
    } else {
      final settings = json.decode(file.readAsStringSync());
      domain = settings['domain'];
    }
  }

  Future<void> save() async {
    final appDir = await getApplicationSupportDirectory();
    final file = File('${appDir.path}/jm_settings.json');
    final settings = {
      'domain': domain,
    };
    file.writeAsStringSync(json.encode(settings));
  }
}
