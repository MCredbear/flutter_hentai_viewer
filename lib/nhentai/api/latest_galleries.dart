part of 'api.dart';

Future<(List<Gallery>, int, int)> latestUpdateGalleries(int pageIndex) async {
  try {
    final response =
        await http.get(Uri.parse(proxy('$hostUrl?page=$pageIndex')));
    return parseGalleriesHtml(response.body);
  } catch (e) {
    throw Exception('Failed to fetch latest update galleries: $e');
  }
}
