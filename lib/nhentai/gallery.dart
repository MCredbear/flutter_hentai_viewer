import 'package:flutter_hentai_viewer/flags.dart';
import 'package:flutter_hentai_viewer/image_meta.dart';

class Gallery {
  Gallery(this.id, this.title, this.coverImageMeta, this.tagIds) {
    languages = [];
    if (tagIds.contains(6346)) {
      languages.add(Language.japanese);
    }
    if (tagIds.contains(29963)) {
      languages.add(Language.chinese);
    }
    if (tagIds.contains(12227)) {
      languages.add(Language.english);
    }
  }

  final int id;
  final String title;
  final ImageMeta coverImageMeta;
  late final List<Language> languages;
  final List<int> tagIds;
}
