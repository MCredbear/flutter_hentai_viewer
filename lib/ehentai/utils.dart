import 'package:flutter/material.dart';

const hostUrl = "https://e-hentai.org";

enum Category {
  doujinshi("Doujinshi", Color.fromRGBO(0xcf, 0x4e, 0x4e, 1), 1 << 1),
  manga("Manga", Color.fromRGBO(0xfc, 0xb4, 0x17, 1), 1 << 2),
  artistCG("Artist CG", Color.fromRGBO(0xdd, 0xe5, 0x00, 1), 1 << 3),
  gameCG("Game CG", Color.fromRGBO(0x05, 0xbf, 0x0b, 1), 1 << 4),
  western("Western", Color.fromRGBO(0x14, 0xe7, 0x23, 1), 1 << 9),
  nonH("Non-H", Color.fromRGBO(0x08, 0xd7, 0xe2, 1), 1 << 8),
  imageSet("Image Set", Color.fromRGBO(0x5f, 0x5f, 0xff, 1), 1 << 5),
  cosplay("Cosplay", Color.fromRGBO(0x05, 0xbf, 0x0b, 1), 1 << 6),
  asianPorn("Asian Porn", Color.fromRGBO(0xfe, 0x93, 0xff, 1), 1 << 7),
  misc("Misc", Color.fromRGBO(0x9e, 0x9e, 0x9e, 1), 1);

  final String string;
  final Color color;
  final int mask;

  const Category(this.string, this.color, this.mask);
}

int categories2fCats(List<Category> categories) {
  int fCats = 1023; // 0b1111111111, all categories disabled
  for (var category in categories) {
    fCats &= ~category.mask; // enable the category
  }

  return fCats;
}
