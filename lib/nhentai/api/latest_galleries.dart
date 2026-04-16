part of 'api.dart';

Future<(List<Gallery>, int)> latestUpdateGalleries(int pageIndex) async {
  try {
    final response = await http.get(Uri.parse(
        proxy('$hostUrl/api/v2/galleries?per_page=25&page=$pageIndex')));
    return parseGalleries(response.bodyBytes);
  } catch (e) {
    throw Exception('Failed to fetch latest update galleries: $e');
  }
}
