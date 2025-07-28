import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/ehentai/pages/favorite_page.dart';
import 'package:flutter_hentai_viewer/ehentai/pages/history_page.dart';
import 'package:flutter_hentai_viewer/ehentai/pages/settings_page.dart';
import 'package:flutter_hentai_viewer/ehentai/pages/tag_filter_page.dart';
import 'package:flutter_hentai_viewer/ehentai/stores/setting_store.dart';
import 'package:flutter_hentai_viewer/ehentai/utils.dart';
import 'package:flutter_hentai_viewer/generated/l10n.dart';
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
                  "assets/ehentai_logo.ico",
                  height: 50,
                  width: 80,
                  scale: 0.5,
                ),
                const Text(
                  "EHentai",
                  textScaler: TextScaler.linear(2.5),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ]),
            ),
          ),
          GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: Category.values.map((category) {
                return Padding(
                  padding: const EdgeInsets.all(4),
                  child: ElevatedButton(
                    onPressed: () {
                      if (ehentaiSettingsStore.enabledCategories
                          .contains(category)) {
                        ehentaiSettingsStore.setEnabledCategory(
                            category, false);
                      } else {
                        ehentaiSettingsStore.setEnabledCategory(category, true);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ehentaiSettingsStore.enabledCategories
                              .contains(category)
                          ? category.color
                          : category.color.withValues(alpha: 0.5),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(category.string),
                  ),
                );
              }).toList()),
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
              leading: const Icon(Icons.favorite),
              title: Text(L10n.of(context).favorite),
              onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const FavoritePage(),
                    ),
                  )),
          if (ehentaiSettingsStore.historyMode != HistoryMode.disabled)
            ListTile(
              leading: const Icon(Icons.history),
              title: Text(L10n.of(context).history),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HistoryPage(),
                ),
              ),
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
