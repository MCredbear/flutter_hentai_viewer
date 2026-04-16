part of 'api.dart';

Future<List<Tag>> searchTags(String query, TagType type) async {
  try {
    final response = await http.post(
        Uri.parse(proxy('$hostUrl/api/v2/tags/search')),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'type': type.name, 'query': query, 'limit': 114514}));
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .cast<Map<String, dynamic>>()
        .map((tagData) => Tag.fromJson(tagData))
        .toList();
  } catch (e) {
    throw ('Error searching tags: $e');
  }
}
