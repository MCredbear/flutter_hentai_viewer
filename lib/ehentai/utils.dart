final category2mask = {
  "Doujinshi": 1 << 1,
  "Manga": 1 << 2,
  "Artist CG": 1 << 3,
  "Game CG": 1 << 4,
  "Western": 1 << 9,
  "Non-H": 1 << 8,
  "Image Set": 1 << 5,
  "Cosplay": 1 << 6,
  "Asian Porn": 1 << 7,
  "Misc": 1,
};

int categories2fCats(List<String> categories) {
  int fCats = 0;
  for (var category in categories) {
    if (category2mask.containsKey(category)) {
      fCats |= category2mask[category]!;
    }
  }
  fCats = ~fCats;
  return fCats;
}
