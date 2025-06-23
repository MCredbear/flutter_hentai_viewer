part of 'api.dart';

Future<(List<Gallery>, int, int)> searchGalleries(String keyword,
    List<Tag> requiredTags, List<Tag> bannedTags, int pageIndex) async {
  try {
    final response = (keyword.isNotEmpty ||
            requiredTags.isNotEmpty ||
            bannedTags.isNotEmpty)
        ? await http.get(Uri.parse(proxy(
            '$hostUrl/search/?q=${(requiredTags + bannedTags).map((tag) => '${tag.tagState == TagState.banned ? '-' : ''}${{
                  TagType.tag: 'tag',
                  TagType.artist: 'artists',
                  TagType.character: 'characters',
                  TagType.parody: 'parodies',
                  TagType.group: 'groups',
                }[tag.tagType]}%3A"${tag.name.replaceAll(' ', '+')}"').join('+')}${keyword.isNotEmpty ? '+${keyword.replaceAll(' ', '+')}' : ''}&page=$pageIndex')))
        : await http.get(Uri.parse(proxy('$hostUrl/?page=$pageIndex')));
    return parseGalleriesHtml(response.body);
  } catch (e) {
    throw Exception('Failed to fetch search galleries: $e');
  }
}
