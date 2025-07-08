part of 'api.dart';

Future<
    (
      String,
      String,
      List<Tag>,
      List<Tag>,
      List<Tag>,
      List<Tag>,
      List<Tag>,
      List<Tag>,
      List<Tag>,
      List<ImageMeta>
    )> galleryInfo(int galleryId) async {
  String title = '';
  String subtitle = '';
  List<Tag> parodyTags = [];
  List<Tag> characterTags = [];
  List<Tag> tagTags = [];
  List<Tag> artistTags = [];
  List<Tag> groupTags = [];
  List<Tag> languageTags = [];
  List<Tag> categoryTags = [];
  List<ImageMeta> previewImageMetas = [];
  try {
    final response = await http.get(Uri.parse(proxy('$hostUrl/g/$galleryId/')));
    final document = html_parser.parse(response.body);
    var infoDiv = document.querySelector('#info')!;
    final titleHs = infoDiv.querySelectorAll('.title');
    title = titleHs.first.children.map((span) => span.text).join();
    subtitle =
        titleHs.lastOrNull?.children.map((span) => span.text).join() ?? '';

    final tagsSection = infoDiv.querySelector('#tags');
    parodyTags = tagsSection!.children[0].children.first.children.map((tagA) {
      final id = int.parse(tagA.className.split(' ')[1].split('-')[1]);
      final nameSpan = tagA.querySelector('.name');
      final name = nameSpan!.text;
      final countSpan = tagA.querySelector('.count');
      final count = countSpan!.text;
      return Tag(id, name, TagType.parody,
          count: count.endsWith('K')
              ? int.parse(count.substring(0, count.length - 1)) * 1000
              : int.parse(count));
    }).toList();
    characterTags = tagsSection.children[1].children.first.children.map((tagA) {
      final id = int.parse(tagA.className.split(' ')[1].split('-')[1]);
      final nameSpan = tagA.querySelector('.name');
      final name = nameSpan!.text;
      final countSpan = tagA.querySelector('.count');
      final count = countSpan!.text;
      return Tag(id, name, TagType.character,
          count: count.endsWith('K')
              ? int.parse(count.substring(0, count.length - 1)) * 1000
              : int.parse(count));
    }).toList();
    tagTags = tagsSection.children[2].children.first.children.map((tagA) {
      final id = int.parse(tagA.className.split(' ')[1].split('-')[1]);
      final nameSpan = tagA.querySelector('.name');
      final name = nameSpan!.text;
      final countSpan = tagA.querySelector('.count');
      final count = countSpan!.text;
      return Tag(id, name, TagType.tag,
          count: count.endsWith('K')
              ? int.parse(count.substring(0, count.length - 1)) * 1000
              : int.parse(count));
    }).toList();
    artistTags = tagsSection.children[3].children.first.children.map((tagA) {
      final id = int.parse(tagA.className.split(' ')[1].split('-')[1]);
      final nameSpan = tagA.querySelector('.name');
      final name = nameSpan!.text;
      final countSpan = tagA.querySelector('.count');
      final count = countSpan!.text;
      return Tag(id, name, TagType.artist,
          count: count.endsWith('K')
              ? int.parse(count.substring(0, count.length - 1)) * 1000
              : int.parse(count));
    }).toList();
    groupTags = tagsSection.children[4].children.first.children.map((tagA) {
      final id = int.parse(tagA.className.split(' ')[1].split('-')[1]);
      final nameSpan = tagA.querySelector('.name');
      final name = nameSpan!.text;
      final countSpan = tagA.querySelector('.count');
      final count = countSpan!.text;
      return Tag(id, name, TagType.group,
          count: count.endsWith('K')
              ? int.parse(count.substring(0, count.length - 1)) * 1000
              : int.parse(count));
    }).toList();
    languageTags = tagsSection.children[5].children.first.children.map((tagA) {
      final id = int.parse(tagA.className.split(' ')[1].split('-')[1]);
      final nameSpan = tagA.querySelector('.name');
      final name = nameSpan!.text;
      final countSpan = tagA.querySelector('.count');
      final count = countSpan!.text;
      return Tag(id, name, TagType.language,
          count: count.endsWith('K')
              ? int.parse(count.substring(0, count.length - 1)) * 1000
              : int.parse(count));
    }).toList();
    categoryTags = tagsSection.children[6].children.first.children.map((tagA) {
      final id = int.parse(tagA.className.split(' ')[1].split('-')[1]);
      final nameSpan = tagA.querySelector('.name');
      final name = nameSpan!.text;
      final countSpan = tagA.querySelector('.count');
      final count = countSpan!.text;
      return Tag(id, name, TagType.category,
          count: count.endsWith('K')
              ? int.parse(count.substring(0, count.length - 1)) * 1000
              : int.parse(count));
    }).toList();

    final thumbsDiv = document.querySelector('.thumbs')!;
    final lazyloadImgs = thumbsDiv.querySelectorAll('.lazyload');
    previewImageMetas = lazyloadImgs
        .map((lazyloadImg) => ImageMeta(
            url: lazyloadImg.attributes['data-src']!,
            width: double.parse(lazyloadImg.attributes['width']!),
            height: double.parse(lazyloadImg.attributes['height']!)))
        .toList();

    return (
      title,
      subtitle,
      parodyTags,
      characterTags,
      tagTags,
      artistTags,
      groupTags,
      languageTags,
      categoryTags,
      previewImageMetas
    );
  } catch (e) {
    throw ('Error fetching gallery info: $e');
  }
}
