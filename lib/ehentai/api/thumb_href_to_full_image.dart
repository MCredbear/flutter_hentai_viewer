part of 'api.dart';

Future<String> thumbHrefToFullImage(String href) async {
  try {
    final response = await http.get(Uri.parse(proxy(href)));
    final document = html_parser.parse(response.body);

    final img = document.querySelector('#img')!;
    final url = img.attributes['src']!;

    return url;
  } catch (e) {
    throw ('Error fetching full image: $e');
  }
}
