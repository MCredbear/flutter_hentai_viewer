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

  final _customizedUserAgentController =
      TextEditingController(text: settingsStore.customizedUserAgent);

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
                          ? ((MediaQuery.of(rootContext).platformBrightness ==
                                  Brightness.dark)
                              ? L10n.current.dark
                              : L10n.current.light)
                          : ((globalSettingsStore.themeData ==
                                  ThemeData.dark(useMaterial3: false))
                              ? L10n.current.dark
                              : L10n.current.light)),
                ),
              ),
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
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

          /// TODO: add these funcions
          // const Divider(),
          // const ListTile(
          //   leading: Text(
          //     "NHentai",
          //     style: TextStyle(color: Colors.blueAccent),
          //   ),
          // ),
          // PopupMenuButton<String>(
          //     child: ListTile(
          //       title: Text(L10n.of(context).titleStyle),
          //       subtitle: Text(settingsStore.titleTypeString),
          //     ),
          //     itemBuilder: (BuildContext context) {
          //       return <PopupMenuEntry<String>>[
          //         PopupMenuItem<String>(
          //           child: Text(L10n.of(context).japanese),
          //           onTap: () => settingsStore.setTitleType(TitleType.japanese),
          //         ),
          //         PopupMenuItem<String>(
          //           child: Text(L10n.of(context).english),
          //           onTap: () => settingsStore.setTitleType(TitleType.english),
          //         ),
          //         PopupMenuItem<String>(
          //           child: Text(L10n.of(context).all),
          //           onTap: () => settingsStore.setTitleType(TitleType.all),
          //         ),
          //       ];
          //     }),
          // ListTile(
          //   title: Text(L10n.of(context).numberOfImageToPreload),
          //   subtitle: Row(
          //     children: [
          //       Expanded(
          //         child: Observer(
          //           builder: (_) => Slider(
          //               min: 1,
          //               max: 25,
          //               divisions: 24,
          //               value: settingsStore.numberOfImageToPreload.toDouble(),
          //               onChanged: (value) {
          //                 settingsStore
          //                     .setNumberOfImageToPreload(value.toInt());
          //               }),
          //         ),
          //       ),
          //       SizedBox(
          //         width: 20,
          //         child: Observer(
          //           builder: (_) =>
          //               Text('${settingsStore.numberOfImageToPreload}'),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // ListTile(
          //   title: Text(L10n.of(context).customizeUserAgent),
          //   subtitle: TextField(
          //     controller: _customizedUserAgentController,
          //     onChanged: (value) {
          //       (value.isEmpty)
          //           ? settingsStore.setCustomizedUserAgent(null)
          //           : settingsStore.setCustomizedUserAgent(value);
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}
