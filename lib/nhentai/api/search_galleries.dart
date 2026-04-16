part of 'api.dart';

Future<(List<Gallery>, int)> searchGalleries(String keyword,
    List<Tag> requiredTags, List<Tag> bannedTags, int pageIndex) async {
  try {
    final query =
        '${(requiredTags + bannedTags).map((tag) => '${tag.tagState == TagState.banned ? '-' : ''}${tag.type!.name}:"${tag.name}"').join(' ')} $keyword';
    final response = await http.get(Uri.parse(proxy(
        '$hostUrl/api/v2/search?query=$query&sort=date&page=$pageIndex')));
    return parseGalleries(response.bodyBytes);
  } catch (e) {
    throw Exception('Failed to fetch search galleries: $e');
  }
}
