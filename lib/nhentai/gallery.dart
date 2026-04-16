import 'package:flutter_hentai_viewer/flags.dart';
import 'package:flutter_hentai_viewer/nhentai/image_meta.dart';
import 'package:flutter_hentai_viewer/nhentai/tag.dart';

class Gallery {
  Gallery(
      {required this.id,
      required this.mediaId,
      required this.englishTitle,
      required this.japaneseTitle,
      this.prettyTitle,
      required this.coverThumbnailMeta,
      this.coverImageMeta,
      required this.numPages,
      this.numFavorites,
      this.uploadDate,
      required this.tags,
      this.thumbnailMetas,
      this.imageMetas}) {
    languages = [];
    if (tags.map((tag) => tag.id).contains(6346)) {
      languages.add(Language.japanese);
    }
    if (tags.map((tag) => tag.id).contains(29963)) {
      languages.add(Language.chinese);
    }
    if (tags.map((tag) => tag.id).contains(12227)) {
      languages.add(Language.english);
    }
  }

  final int id;
  final String mediaId;

  final String? englishTitle;
  final String? japaneseTitle;
  final String? prettyTitle;

  final ImageMeta coverThumbnailMeta;
  final ImageMeta? coverImageMeta;

  final int numPages;

  final int? numFavorites;

  final int? uploadDate;

  late final List<Language> languages;
  final List<Tag> tags;

  final List<ImageMeta>? thumbnailMetas;
  final List<ImageMeta>? imageMetas;

  factory Gallery.fromJson(Map<String, dynamic> json) {
    return Gallery(
      id: json['id'] as int,
      mediaId: json['mediaId'] as String,
      englishTitle: json['englishTitle'] as String?,
      japaneseTitle: json['japaneseTitle'] as String?,
      prettyTitle: json['prettyTitle'] as String?,
      coverThumbnailMeta: ImageMeta.fromJson(
          json['coverThumbnailMeta'] as Map<String, dynamic>),
      coverImageMeta: json['coverImageMeta'] == null
          ? null
          : ImageMeta.fromJson(json['coverImageMeta'] as Map<String, dynamic>),
      numPages: json['numPages'] as int,
      numFavorites:
          json['numFavorites'] == null ? null : json['numFavorites'] as int,
      uploadDate: json['uploadDate'] == null ? null : json['uploadDate'] as int,
      tags: (json['tags'] as List<dynamic>)
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      thumbnailMetas: json['thumbnailMetas'] == null
          ? null
          : (json['thumbnailMetas'] as List<dynamic>)
              .map((e) => ImageMeta.fromJson(e as Map<String, dynamic>))
              .toList(),
      imageMetas: json['imageMetas'] == null
          ? null
          : (json['imageMetas'] as List<dynamic>)
              .map((e) => ImageMeta.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mediaId': mediaId,
      'englishTitle': englishTitle,
      'japaneseTitle': japaneseTitle,
      'prettyTitle': prettyTitle,
      'coverThumbnailMeta': coverThumbnailMeta.toJson(),
      'coverImageMeta': coverImageMeta?.toJson(),
      'numPages': numPages,
      'numFavorites': numFavorites,
      'uploadDate': uploadDate,
      'tags': tags.map((e) => e.toJson()).toList(),
      'thumbnailMetas': thumbnailMetas?.map((e) => e.toJson()).toList(),
      'imageMetas': imageMetas?.map((e) => e.toJson()).toList(),
    };
  }
}
