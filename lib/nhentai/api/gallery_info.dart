part of 'api.dart';

Future<Gallery> galleryInfo(int galleryId) async {
  try {
    final response = await http
        .get(Uri.parse(proxy('$hostUrl/api/v2/galleries/$galleryId')));
    final data =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    final id = data['id'] as int;
    final mediaId = data['media_id'] as String;
    final englishTitle = data['title']['english'] as String;
    final japaneseTitle = data['title']['japanese'] as String;
    final prettyTitle = data['title']['pretty'] as String?;
    final coverThumbnailMeta = ImageMeta(
        path: data['thumbnail']['path'] as String,
        width: data['thumbnail']['width'] as num,
        height: data['thumbnail']['height'] as num);
    final coverImageMeta = ImageMeta(
        path: data['cover']['path'] as String,
        width: data['cover']['width'] as num,
        height: data['cover']['height'] as num);
    final numPages = data['num_pages'] as int;
    final numFavorites = data['num_favorites'] as int?;
    final uploadDate = data['upload_date'] as int?;
    final tags = (data['tags'] as List)
        .cast<Map<String, dynamic>>()
        .map((tag) => Tag.fromJson(tag))
        .toList();
    final thumbnailMetas = (data['pages'] as List)
        .cast<Map<String, dynamic>>()
        .map((page) => ImageMeta(
            path: page['thumbnail'] as String,
            width: page['thumbnail_width'] as num,
            height: page['thumbnail_height'] as num))
        .toList();
    final imageMetas = (data['pages'] as List)
        .cast<Map<String, dynamic>>()
        .map((page) => ImageMeta(
            path: page['path'] as String,
            width: page['width'] as num,
            height: page['height'] as num))
        .toList();
    final gallery = Gallery(
        id: id,
        mediaId: mediaId,
        englishTitle: englishTitle,
        japaneseTitle: japaneseTitle,
        prettyTitle: prettyTitle,
        coverThumbnailMeta: coverThumbnailMeta,
        coverImageMeta: coverImageMeta,
        numPages: numPages,
        numFavorites: numFavorites,
        uploadDate: uploadDate,
        tags: tags,
        thumbnailMetas: thumbnailMetas,
        imageMetas: imageMetas);

    return gallery;
  } catch (e) {
    throw ('Error fetching gallery info: $e');
  }
}
