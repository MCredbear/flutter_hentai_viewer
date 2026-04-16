import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_hentai_viewer/nhentai/image_meta.dart';
import 'package:flutter_hentai_viewer/nhentai/gallery.dart';
import 'package:flutter_hentai_viewer/nhentai/tag.dart';
import 'package:flutter_hentai_viewer/nhentai/utils.dart';
import 'package:flutter_hentai_viewer/utils.dart';
import 'package:http/http.dart' as http;

part 'search_tags.dart';
part 'latest_galleries.dart';
part 'search_galleries.dart';
part 'search_by_single_tag.dart';
part 'gallery_info.dart';

(List<Gallery>, int) parseGalleries(Uint8List body) {
  final data = jsonDecode(utf8.decode(body)) as Map<String, dynamic>;
  final galleries = (data['result'] as List)
      .cast<Map<String, dynamic>>()
      .map((galleryData) => Gallery(
            id: galleryData['id'] as int,
            mediaId: galleryData['media_id'] as String,
            englishTitle: galleryData['english_title'] as String?,
            japaneseTitle: galleryData['japanese_title'] as String?,
            coverThumbnailMeta: ImageMeta(
                path: galleryData['thumbnail'] as String,
                width: galleryData['thumbnail_width'] as num,
                height: galleryData['thumbnail_height'] as num),
            numPages: galleryData['num_pages'] as int,
            tags: (galleryData['tag_ids'] as List)
                .cast<int>()
                .map((tagId) => Tag(tagId))
                .toList(),
          ))
      .toList();
  final numPages = data['num_pages'] as int;
  return (galleries, numPages);
}
