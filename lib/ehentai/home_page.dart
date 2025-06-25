import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EHentai"),
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
