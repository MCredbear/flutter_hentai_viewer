import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/generated/l10n.dart';
import 'package:flutter_hentai_viewer/global_settings_store.dart';
import 'package:flutter_hentai_viewer/nhentai/stores/setting_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  late final localeCode2Language = {
    'null': L10n.of(context).dependsOnSystem,
    'en_US': 'English',
    'ja_JP': '日本語',
    'zh_CN': '简体中文',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(L10n.of(context).settings)),
      body: ListView(
        children: [
          ListTile(
            leading: Text(
              L10n.of(context).global,
              style: const TextStyle(color: Colors.blueAccent),
            ),
          ),
          PopupMenuButton<String>(
              child: ListTile(
                title: Text(L10n.of(context).language),
                subtitle: Observer(
                  builder: (context) {
                    final localCode = globalSettingsStore.locale != null
                        ? '${globalSettingsStore.locale!.languageCode}_${globalSettingsStore.locale!.countryCode}'
                        : null;
                    return Text(localeCode2Language[localCode] ??
                        L10n.of(context).dependsOnSystem);
                  },
                ),
              ),
              onSelected: (value) {
                if (value == 'null') {
                  globalSettingsStore.setLocale(null);
                } else {
                  globalSettingsStore.setLocale(
                      Locale(value.substring(0, 2), value.substring(3)));
                }
                globalSettingsStore.save();
              },
              itemBuilder: (BuildContext context) => localeCode2Language.entries
                  .map((entry) => PopupMenuItem<String>(
                      value: entry.key, child: Text(entry.value)))
                  .toList()),
          PopupMenuButton<String>(
              child: ListTile(
                  title: Text(L10n.of(context).readingDirection),
                  subtitle: Observer(
                    builder: (context) => Text(
                        (globalSettingsStore.readingDirection ==
                                TextDirection.ltr)
                            ? L10n.of(context).leftToRight
                            : L10n.of(context).rightToLeft),
                  )),
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    child: Text(L10n.of(context).leftToRight),
                    onTap: () {
                      globalSettingsStore
                          .setReadingDirection(TextDirection.ltr);
                    },
                  ),
                  PopupMenuItem<String>(
                    child: Text(L10n.of(context).rightToLeft),
                    onTap: () {
                      globalSettingsStore
                          .setReadingDirection(TextDirection.rtl);
                    },
                  ),
                ];
              }),
          PopupMenuButton<String>(
              child: ListTile(
                title: Text(L10n.of(context).theme),
                subtitle: Observer(
                  builder: (context) => Text(
                      (globalSettingsStore.themeData == null)
                          ? L10n.of(context).dependsOnSystem
                          : ((globalSettingsStore.themeData ==
                                  ThemeData.dark(useMaterial3: false))
                              ? L10n.of(context).dark
                              : L10n.of(context).light)),
                ),
              ),
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    child: Text(L10n.of(context).dependsOnSystem),
                    onTap: () => globalSettingsStore.setThemeData(null),
                  ),
                  PopupMenuItem<String>(
                    child: Text(L10n.of(context).dark),
                    onTap: () => globalSettingsStore
                        .setThemeData(ThemeData.dark(useMaterial3: false)),
                  ),
                  PopupMenuItem<String>(
                    child: Text(L10n.of(context).light),
                    onTap: () => globalSettingsStore
                        .setThemeData(ThemeData.light(useMaterial3: false)),
                  ),
                ];
              }),
          ListTile(
            leading: Text(L10n.of(context).scrollUpToLoadMore),
            trailing: Observer(
              builder: (context) => Switch(
                value: globalSettingsStore.scrollUpToLoadMore,
                onChanged: (value) =>
                    globalSettingsStore.setScrollUpToLoadMore(value),
              ),
            ),
          ),
          ListTile(
            title: Text(L10n.of(context).preloadImageCount),
            subtitle: Observer(
              builder: (context) => Slider(
                min: 1,
                max: 25,
                divisions: 24,
                value: globalSettingsStore.preloadImageCount.toDouble(),
                onChanged: (value) {
                  globalSettingsStore.setPreloadImageCount(value.toInt());
                },
              ),
            ),
            trailing: Observer(
              builder: (context) => Text(
                '${globalSettingsStore.preloadImageCount}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          PopupMenuButton<String>(
              child: ListTile(
                title: Text(L10n.of(context).proxyMode),
                subtitle: Observer(
                  builder: (context) =>
                      Text(switch (globalSettingsStore.proxyMode) {
                    ProxyMode.cloudflare => "Cloudflare",
                    ProxyMode.vercel => "Vercel",
                    ProxyMode.none => L10n.of(context).none,
                    _ => "Vercel",
                  }),
                ),
              ),
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    child: const Text("Cloudflare"),
                    onTap: () =>
                        globalSettingsStore.setProxyMode(ProxyMode.cloudflare),
                  ),
                  PopupMenuItem<String>(
                    child: const Text("Vercel"),
                    onTap: () =>
                        globalSettingsStore.setProxyMode(ProxyMode.vercel),
                  ),
                  PopupMenuItem<String>(
                    child: Text(L10n.of(context).none),
                    onTap: () =>
                        globalSettingsStore.setProxyMode(ProxyMode.none),
                  ),
                ];
              }),
          const Divider(),
          const ListTile(
            leading: Text(
              "NHentai",
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
          ListTile(
            leading: Text(L10n.of(context).autoUpdateTags),
            trailing: Observer(
              builder: (context) => Switch(
                value: nhentaiSettingsStore.autoUpdateTags,
                onChanged: (value) =>
                    nhentaiSettingsStore.setAutoUpdateTags(value),
              ),
            ),
          ),
          PopupMenuButton<String>(
              child: ListTile(
                title: Text(L10n.of(context).historyMode),
                subtitle: Observer(
                  builder: (context) =>
                      Text(switch (nhentaiSettingsStore.historyMode) {
                    HistoryMode.disabled => L10n.of(context).disabled,
                    HistoryMode.infinite => L10n.of(context).infinite,
                    HistoryMode.limited => L10n.of(context).limited
                  }),
                ),
              ),
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    child: Text(L10n.of(context).disabled),
                    onTap: () => nhentaiSettingsStore
                        .setHistoryState(HistoryMode.disabled),
                  ),
                  PopupMenuItem<String>(
                    child: Text(L10n.of(context).infinite),
                    onTap: () => nhentaiSettingsStore
                        .setHistoryState(HistoryMode.infinite),
                  ),
                  PopupMenuItem<String>(
                    child: Text(L10n.of(context).limited),
                    onTap: () => nhentaiSettingsStore
                        .setHistoryState(HistoryMode.limited),
                  ),
                ];
              }),
          Observer(
            builder: (context) => ListTile(
              enabled: nhentaiSettingsStore.historyMode == HistoryMode.limited,
              title: Text(L10n.of(context).historyLimit),
              subtitle: Observer(
                builder: (context) => Slider(
                  min: 100,
                  max: 1000,
                  divisions: 9,
                  value: nhentaiSettingsStore.maxHistoryGalleries.toDouble(),
                  onChanged: (value) {
                    if (nhentaiSettingsStore.historyMode ==
                        HistoryMode.limited) {
                      nhentaiSettingsStore
                          .setMaxHistoryGalleries(value.toInt());
                    }
                  },
                ),
              ),
              trailing: Observer(
                builder: (context) => Text(
                  '${nhentaiSettingsStore.maxHistoryGalleries}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          PopupMenuButton<String>(
              child: ListTile(
                title: Text(L10n.of(context).showHistoryMode),
                subtitle: Observer(
                  builder: (context) =>
                      Text(switch (nhentaiSettingsStore.showHistoryMode) {
                    ShowHistoryMode.addAPin => L10n.of(context).addAPin,
                    ShowHistoryMode.doNotShow => L10n.of(context).doNotShow,
                    ShowHistoryMode.showNormally =>
                      L10n.of(context).showNormally,
                  }),
                ),
              ),
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    child: Text(L10n.of(context).addAPin),
                    onTap: () => nhentaiSettingsStore
                        .setShowHistoryState(ShowHistoryMode.addAPin),
                  ),
                  PopupMenuItem<String>(
                    child: Text(L10n.of(context).doNotShow),
                    onTap: () => nhentaiSettingsStore
                        .setShowHistoryState(ShowHistoryMode.doNotShow),
                  ),
                  PopupMenuItem<String>(
                    child: Text(L10n.of(context).showNormally),
                    onTap: () => nhentaiSettingsStore
                        .setShowHistoryState(ShowHistoryMode.showNormally),
                  ),
                ];
              }),
          PopupMenuButton<String>(
              child: ListTile(
                title: Text(L10n.of(context).showFavoriteMode),
                subtitle: Observer(
                  builder: (context) =>
                      Text(switch (nhentaiSettingsStore.showFavoriteMode) {
                    ShowFavoriteMode.addAPin => L10n.of(context).addAPin,
                    ShowFavoriteMode.showNormally =>
                      L10n.of(context).showNormally,
                  }),
                ),
              ),
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    child: Text(L10n.of(context).addAPin),
                    onTap: () => nhentaiSettingsStore
                        .setShowFavoriteState(ShowFavoriteMode.addAPin),
                  ),
                  PopupMenuItem<String>(
                    child: Text(L10n.of(context).showNormally),
                    onTap: () => nhentaiSettingsStore
                        .setShowFavoriteState(ShowFavoriteMode.showNormally),
                  ),
                ];
              }),
        ],
      ),
    );
  }
}
