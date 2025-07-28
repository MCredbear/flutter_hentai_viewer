import 'package:flutter_hentai_viewer/nhentai/image_meta.dart';
import 'package:flutter_hentai_viewer/ehentai/tag.dart';

class Gallery {
  Gallery(this.id, this.hash, this.title, this.coverImageMeta, this.tags,
      this.pages);

  final int id;
  final String hash;
  final String title;
  final ImageMeta coverImageMeta;
  final List<Tag> tags;
  final int pages;

  factory Gallery.fromJson(Map<String, dynamic> json) {
    return Gallery(
      json['id'] as int,
      json['hash'] as String,
      json['title'] as String,
      ImageMeta.fromJson(json['coverImageMeta'] as Map<String, dynamic>),
      json['tags'] as List<Tag>,
      json['pages'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hash': hash,
      'title': title,
      'coverImageMeta': coverImageMeta.toJson(),
      'tags': tags,
      'pages': pages,
    };
  }
}
