import 'package:flutter_hentai_viewer/nhentai/stores/tag_filter_store.dart';
import 'package:flutter_hentai_viewer/nhentai/stores/setting_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/generated/l10n.dart';
import 'package:flutter_hentai_viewer/global_settings_store.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_hentai_viewer/nhentai/pages/home_page.dart' as nhentai;
import 'package:toastification/toastification.dart';

void main() => runApp(const MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool settingsLoaded = false;

  @override
  void initState() {
    super.initState();
    globalSettingsStore.read().then((_) => settingsStore
        .read()
        .then((_) => tagFilterStore.read().then((_) => setState(() {
              settingsLoaded = true;
            }))));
  }

  @override
  Widget build(BuildContext context) {
    rootContext = context;
    return settingsLoaded
        ? ToastificationWrapper(
            child: Observer(
              builder: (_) => MaterialApp(
                localizationsDelegates: const [
                  L10n.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: L10n.delegate.supportedLocales,
                locale: globalSettingsStore.locale,
                theme: (globalSettingsStore.themeData == null)
                    ? ((MediaQuery.of(context).platformBrightness ==
                            Brightness.dark)
                        ? ThemeData.dark(useMaterial3: false)
                        : ThemeData.light(useMaterial3: false))
                    : globalSettingsStore.themeData,
                title: "FhViewer",
                home: const nhentai.HomePage(),
              ),
            ),
          )
        : Container(
            color: Colors.white10,
          );
  }
}
