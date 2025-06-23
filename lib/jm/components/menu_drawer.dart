import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/generated/l10n.dart';
import 'package:flutter_hentai_viewer/jm/components/select_domain_dialog.dart';
import 'package:flutter_hentai_viewer/jm/pages/settings_page.dart';
import 'package:flutter_hentai_viewer/switch_source_dialog.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer(
    this.refreshHomePage, {
    super.key,
  });

  final Function refreshHomePage;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        Card(
          margin: const EdgeInsets.all(0),
          child: Container(
            decoration: const BoxDecoration(color: Colors.black),
            height: 100,
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 15),
                child: Image.asset(
                  "assets/jm_logo.png",
                  height: 50,
                ),
              ),
              const Text(
                "JM",
                textScaler: TextScaler.linear(2.5),
              )
            ]),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: Text(L10n.of(context).settings),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const SettingsPage()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.speed),
          title: Text(L10n.of(context).selectDomain),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => const SelectDomainDialog());
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.language),
          title: Text(L10n.of(context).switchSource),
          onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) => const SwitchSourceDialog(),
          ),
        ),
      ]),
    );
  }
}
