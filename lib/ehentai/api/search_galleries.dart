part of 'api.dart';

/// `nextGalleryId` will invalid `prevGalleryId`
Future<(List<Gallery> galleries, bool hasPreviousPage, bool hasNextPage)>
    searchGalleries(
        {List<Category>? categories,
        String? keyword,
        int? nextGalleryId,
        int? prevGalleryId}) async {
  try {
    final fCats =
        categories != null ? 'f_cats=${categories2fCats(categories)}' : '';
    final fSearch = keyword != null ? '&f_search=$keyword' : '';
    final next = nextGalleryId != null ? '&next=$nextGalleryId' : '';
    final prev = prevGalleryId != null ? '&prev=$prevGalleryId' : '';
    final response =
        await http.get(Uri.parse(proxy('$hostUrl?$fCats$fSearch$next$prev')));

    List<Gallery> galleries = [];
    bool hasPreviousPage = false;
    bool hasNextPage = false;

    try {
      final document = html_parser.parse(response.body);
      final table = document.querySelector('table.itg.gltc');
      if (table != null) {
        final tbody = table.querySelector('tbody')!;
        final rows = tbody.querySelectorAll('tr').sublist(1);
        for (final row in rows) {
          try {
            final gl2cTd = row.querySelector('td.gl2c')!;
            final glthumbDiv = gl2cTd.querySelector('.glthumb')!;
            final cover = glthumbDiv.querySelector('img')!;
            final style = cover.attributes['style']!;
            final styleParts = style.split(';');
            final imageMeta = ImageMeta(
              url: cover.attributes['data-src']!,
              width: double.parse(styleParts
                  .firstWhere((part) => part.contains('width'))
                  .split(':')[1]
                  .split('px')[0]),
              height: double.parse(styleParts
                  .firstWhere((part) => part.contains('height'))
                  .split(':')[1]
                  .split('px')[0]),
            );

            final gl3cTd = row.querySelector('.gl3c')!;
            final a = gl3cTd.querySelector('a')!;
            final url = a.attributes['href']!;
            final id = int.parse(url.split('/')[4]);
            final hash = url.split('/')[5];

            final glinkDiv = a.querySelector('.glink')!;
            final title = glinkDiv.text;

            final gtDivs = a.querySelectorAll('.gt');
            final tags = gtDivs.map((gtDiv) {
              final title = gtDiv.attributes['title']!;
              final type = switch (title.split(':')[0]) {
                'parody' => TagType.parody,
                'character' => TagType.character,
                'artist' => TagType.artist,
                'group' => TagType.group,
                'language' => TagType.language,
                'female' => TagType.female,
                'male' => TagType.male,
                'mixed' => TagType.mixed,
                'other' => TagType.other,
                _ => throw Exception('Unknown tag type: $title'),
              };
              final name = title.split(':')[1];

              return Tag(name, type);
            }).toList();

            final gl4cTd = row.querySelector('.gl4c')!;
            final pagesDiv = gl4cTd.children[1];
            final pages = int.parse(pagesDiv.text.split(' ')[0]);

            galleries.add(Gallery(
              id,
              hash,
              title,
              imageMeta,
              tags,
              pages,
            ));
          } catch (e) {
            // Usually caused by advertisement
            continue;
          }
        }
      }

      final uprev = document.querySelector('#uprev')!;
      if (uprev.localName == 'a') {
        hasPreviousPage = true;
      }
      final unext = document.querySelector('#unext')!;
      if (unext.localName == 'a') {
        hasNextPage = true;
      }
    } catch (e) {
      throw Exception('Failed to parse HTML: $e');
    }
    return (galleries, hasPreviousPage, hasNextPage);
  } catch (e) {
    throw Exception('Failed to fetch latest update galleries: $e');
  }
}
