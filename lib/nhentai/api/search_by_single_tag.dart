part of 'api.dart';

Future<(List<Gallery>, int, int)> searchBySingleTag(
    Tag tag, int pageIndex) async {
  try {
    final response = await http.get(Uri.parse(proxy(
        '$hostUrl/${tag.tagType.name}/${tag.name.replaceAll(' ', '-')}/?page=$pageIndex')));
    return parseGalleriesHtml(response.body);
  } catch (e) {
    throw Exception('Failed to fetch latest update galleries: $e');
  }
}
