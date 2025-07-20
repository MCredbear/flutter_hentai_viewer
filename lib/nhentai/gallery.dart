import 'package:flutter_hentai_viewer/flags.dart';
import 'package:flutter_hentai_viewer/nhentai/image_meta.dart';

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

  factory Gallery.fromJson(Map<String, dynamic> json) {
    return Gallery(
      json['id'] as int,
      json['title'] as String,
      ImageMeta.fromJson(json['coverImageMeta'] as Map<String, dynamic>),
      (json['tagIds'] as List<dynamic>).cast<int>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'coverImageMeta': coverImageMeta.toJson(),
      'tagIds': tagIds,
    };
  }
}
