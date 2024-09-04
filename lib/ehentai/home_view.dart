import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FhViewer"),
      ),
      drawer: Drawer(
        child: ListView(children: const []),
      ),
      body: const Center(
        child: Text('Hello World!'),
      ),
    );
  }
}
