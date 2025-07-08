import 'package:flutter_hentai_viewer/image_meta.dart';
import 'package:flutter_hentai_viewer/nhentai/gallery.dart';
import 'package:flutter_hentai_viewer/nhentai/tag.dart';
import 'package:flutter_hentai_viewer/nhentai/utils.dart';
import 'package:flutter_hentai_viewer/utils.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;

part 'latest_galleries.dart';
part 'search_galleries.dart';
part 'search_by_single_tag.dart';
part 'gallery_info.dart';

(List<Gallery>, int, int) parseGalleriesHtml(String html) {
  List<Gallery> galleries = [];
  int currentPageIndex = 1;
  int totalPages = 1;

  try {
    final document = html_parser.parse(html);
    final galleryContainerDivs =
        document.querySelectorAll('.container.index-container');
    final paginationSection = document.querySelector('.pagination');

    if (galleryContainerDivs.isNotEmpty) {
      final gallerieDivs = [];
      for (final galleryContainerDiv in galleryContainerDivs) {
        gallerieDivs.addAll(galleryContainerDiv.querySelectorAll('.gallery'));
      }

      galleries = gallerieDivs.map((galleryDiv) {
        final coverA = galleryDiv.querySelector('.cover');
        final id = int.parse(coverA!.attributes['href']!.split('/')[2]);
        final captionDiv = galleryDiv.querySelector('.caption');
        final title = captionDiv!.text;
        final lazyLoadImg = galleryDiv.querySelector('.lazyload');
        final coverImageMeta = ImageMeta(
            url: lazyLoadImg!.attributes['data-src']!,
            width: double.parse(lazyLoadImg.attributes['width']!),
            height: double.parse(lazyLoadImg.attributes['height']!));
        final tagIds = galleryDiv.attributes['data-tags']!
            .split(' ')
            .map((e) => int.parse(e))
            .toList()
            .cast<int>();
        return Gallery(id, title, coverImageMeta, tagIds);
      }).toList();

      if (paginationSection != null) {
        final pageCurrentA = paginationSection.querySelector('.page.current')!;
        currentPageIndex = int.parse(pageCurrentA.text);
        final lastA = paginationSection.querySelector('.last');
        if (lastA != null) {
          totalPages = int.parse(lastA.attributes['href']!.split('page=')[1]);
        } else {
          totalPages = currentPageIndex;
        }
      }
    }
  } catch (e) {
    throw Exception('Failed to parse HTML: $e');
  }
  return (galleries, currentPageIndex, totalPages);
}
