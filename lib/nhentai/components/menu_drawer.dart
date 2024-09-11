import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/generated/l10n.dart';
import 'package:flutter_hentai_viewer/nhentai/pages/settings_page.dart';
import 'package:flutter_hentai_viewer/nhentai/pages/tag_filter_page.dart';

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
        // TODO: add these functions
        // ListTile(
        //   leading: const Icon(Icons.download),
        //   title: Text(L10n.of(context).downloadedGalleries),
        //   onTap: () {},
        // ),
        // ListTile(
        //   leading: const Icon(Icons.favorite),
        //   title: Text(L10n.of(context).favoriteGalleries),
        //   onTap: () {},
        // ),
        // ListTile(
        //   leading: const Icon(Icons.history),
        //   title: Text(L10n.of(context).history),
        //   onTap: () {},
        // ),
        // const Divider(),
        ListTile(
          leading: const Icon(Icons.tag),
          title: Text(L10n.of(context).tagFilter),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (context) => const TagFilterPage()))
                .then((_) => refreshHomePage());
          },
        ),
        const Divider(),
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
      ]),
    );
  }
}
