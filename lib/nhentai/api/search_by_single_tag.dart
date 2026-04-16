part of 'api.dart';

Future<(List<Gallery>, int)> searchBySingleTag(Tag tag, int pageIndex) async {
  try {
    final query = '${tag.type!.name}:"${tag.name}"';
    final response = await http.get(Uri.parse(proxy(
        '$hostUrl/api/v2/search?query=$query&sort=date&page=$pageIndex')));
    return parseGalleries(response.bodyBytes);
  } catch (e) {
    throw Exception('Failed to fetch latest update galleries: $e');
  }
}
