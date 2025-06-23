import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/generated/l10n.dart';
import 'package:flutter_hentai_viewer/jm/stores/setting_store.dart';
import 'package:flutter_hentai_viewer/jm/utils.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SelectDomainDialog extends StatelessWidget {
  const SelectDomainDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return AlertDialog(
        title: Text(L10n.of(context).selectDomain),
        actions: [
          TextButton(
            child: Text(L10n.of(context).testSpeed),
            onPressed: () {
              for (var domain in domains) {
                pingDomain(domain).then((latency) {
                  jmSettingsStore.setDomainLatency(domain, latency);
                });
              }
            },
          ),
          TextButton(
            child: Text(L10n.of(context).ok),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        content: Observer(
          builder: (context) => RadioGroup(
            groupValue: jmSettingsStore.domain,
            onChanged: (_) {},
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: domains
                    .map((domain) => ListTile(
                          leading: Radio(value: domain),
                          title: Text(domain),
                          subtitle: Observer(
                            builder: (context) => Text(
                              jmSettingsStore.domain2latency[domain] == -1
                                  ? L10n.of(context).unreachable
                                  : jmSettingsStore.domain2latency[domain] ==
                                          null
                                      ? '? ms'
                                      : '${jmSettingsStore.domain2latency[domain]} ms',
                            ),
                          ),
                          onTap: () => jmSettingsStore.setDomain(domain),
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
      );
    });
  }
}
