import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/generated/l10n.dart';
import 'package:flutter_hentai_viewer/nhentai/pages/favorite_page.dart';
import 'package:flutter_hentai_viewer/nhentai/pages/history_page.dart';
import 'package:flutter_hentai_viewer/nhentai/pages/settings_page.dart';
import 'package:flutter_hentai_viewer/nhentai/pages/tag_filter_page.dart';
import 'package:flutter_hentai_viewer/nhentai/stores/setting_store.dart';
import 'package:flutter_hentai_viewer/switch_source_dialog.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Observer(
        builder: (context) => ListView(children: [
          Card(
            margin: const EdgeInsets.all(0),
            child: Container(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              height: 100,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Image.asset(
                  "assets/nhentai_logo.png",
                  height: 50,
                ),
                const Text(
                  "NHentai",
                  textScaler: TextScaler.linear(2.5),
                )
              ]),
            ),
          ),
          ListTile(
              leading: const Icon(Icons.favorite),
              title: Text(L10n.of(context).favorite),
              onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const FavoritePage(),
                    ),
                  )),
          if (nhentaiSettingsStore.historyMode != HistoryMode.disabled)
            ListTile(
              leading: const Icon(Icons.history),
              title: Text(L10n.of(context).history),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HistoryPage(),
                ),
              ),
            ),
          // TODO: add these functions
          // ListTile(
          //   leading: const Icon(Icons.download),
          //   title: Text(L10n.of(context).downloadedGalleries),
          //   onTap: () {},
          // ),
          // const Divider(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.tag),
            title: Text(L10n.of(context).tagFilter),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const TagFilterPage()));
            },
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
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(L10n.of(context).switchSource),
            onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) => const SwitchSourceDialog(),
            ),
          )
        ]),
      ),
    );
  }
}
