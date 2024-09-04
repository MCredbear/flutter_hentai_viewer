import 'package:flutter/material.dart';

enum Language { japanese, chinese, english }

class Flag extends StatelessWidget {
  const Flag(
    this.language, {
    super.key,
  });

  final Language language;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 20,
        height: 20,
        child: Image.asset((switch (language) {
          Language.japanese => 'assets/jp_flag.gif',
          Language.chinese => 'assets/cn_flag.gif',
          Language.english => 'assets/en_flag.gif',
        })));
  }
}
