import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/generated/l10n.dart';
import 'package:flutter_hentai_viewer/global_settings_store.dart';

class SwitchSourceDialog extends StatelessWidget {
  const SwitchSourceDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(L10n.of(context).switchSource),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Image.asset(
              "assets/nhentai_logo.png",
              width: 50,
            ),
            title: const Text("NHentai"),
            onTap: () {
              globalSettingsStore.setSource("nhentai");
              Navigator.of(context).pop();
            },
          ),
          const Divider(),
          ListTile(
            leading: Image.asset(
              "assets/ehentai_logo.ico",
              width: 50,
            ),
            title: const Text("EHentai"),
            onTap: () {
              globalSettingsStore.setSource("nhentai");
              Navigator.of(context).pop();
            },
          ),
          const Divider(),
          ListTile(
            leading: Image.asset(
              "assets/jm_logo.png",
              width: 50,
            ),
            title: const Text("JM"),
            onTap: () {
              globalSettingsStore.setSource("jm");
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(L10n.of(context).cancel),
        ),
      ],
    );
  }
}
