import 'package:flutter_hentai_viewer/nhentai/pages/home_page.dart' as nhentai;
import 'package:flutter_hentai_viewer/jm/pages/home_page.dart' as jm;
import 'package:flutter_hentai_viewer/switch_source_dialog.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/generated/l10n.dart';
import 'package:flutter_hentai_viewer/global_settings_store.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:toastification/toastification.dart';

void main() => runApp(const MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    globalSettingsStore.read().then((_) => setState(() {
          isLoading = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ToastificationWrapper(
            child: Observer(
              builder: (context) => MaterialApp(
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
                home: switch (globalSettingsStore.source) {
                  "nhentai" => const nhentai.HomePage(),
                  "jm" => const jm.HomePage(),
                  _ => const SwitchSourceDialog(),
                },
              ),
            ),
          );
  }
}
