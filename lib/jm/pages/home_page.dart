import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/jm/components/menu_drawer.dart';
import 'package:flutter_hentai_viewer/jm/components/select_domain_dialog.dart';
import 'package:flutter_hentai_viewer/jm/stores/setting_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    () async {
      await jmSettingsStore.read();
    }.call().then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: const Text("JM"),
            ),
            drawer: Drawer(child: MenuDrawer(() {})),
            body: Observer(
                builder: (context) => jmSettingsStore.domain == null
                    ? const SelectDomainDialog()
                    : Center(
                        child: Text(
                          "Current domain: ${jmSettingsStore.domain}",
                          style: const TextStyle(fontSize: 20),
                        ),
                      )),
          );
  }
}
