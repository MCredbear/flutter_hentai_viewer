import 'package:flutter_hentai_viewer/flags.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gallery.g.dart';

@JsonSerializable()
class Gallery {
  Gallery(this.id, this.title, this.coverImageUrl, this.tagIds) {
    // if (tagIds.contains(6346)) return Language.japanese;
    if (tagIds.contains(29963)) {
      language = Language.chinese;
      return;
    }
    if (tagIds.contains(12227)) {
      language = Language.english;
      return;
    }
    language = Language.japanese;
  }

  final int id;
  final String title;
  final String coverImageUrl;
  late final Language language;
  final List<int> tagIds;

  factory Gallery.fromJson(Map<String, dynamic> json) =>
      _$GalleryFromJson(json);

  Map<String, dynamic> toJson() => _$GalleryToJson(this);
}
