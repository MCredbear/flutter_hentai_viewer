part of 'api.dart';

Future<
    (
      String title,
      String subtitle,
      List<Tag> languageTags,
      List<Tag> parodyTags,
      List<Tag> characterTags,
      List<Tag> artistTags,
      List<Tag> groupTags,
      List<Tag> femaleTags,
      List<Tag> maleTags,
      List<Tag> mixedTags,
      List<Tag> otherTags,
      Category category,
      String language,
      List<ThumbMeta> previewImageMetas,
      int totalPagesCount,
    )> galleryInfo(Gallery gallery, {int pageIndex = 0}) async {
  String title = '';
  String subtitle = '';
  List<Tag> languageTags = [];
  List<Tag> parodyTags = [];
  List<Tag> characterTags = [];
  List<Tag> artistTags = [];
  List<Tag> groupTags = [];
  List<Tag> femaleTags = [];
  List<Tag> maleTags = [];
  List<Tag> mixedTags = [];
  List<Tag> otherTags = [];
  late Category category;
  late String language;
  List<ThumbMeta> previewImageMetas = [];
  try {
    final response = await http.get(Uri.parse(
        proxy('$hostUrl/g/${gallery.id}/${gallery.hash}/?p=$pageIndex')));
    final document = html_parser.parse(response.body);

    final gnH1 = document.querySelector('#gn')!;
    title = gnH1.text;
    final gjH1 = document.querySelector('#gj')!;
    subtitle = gjH1.text;

    final taglistDiv = document.querySelector('#taglist')!;
    final taglistTRs = taglistDiv.children.first.children.first.children;
    for (final taglistTR in taglistTRs) {
      final tagTypeString = taglistTR.children[0].text;
      final tagNames = taglistTR.children[1].children
          .map((div) => div.children.first.text)
          .toList();
      switch (tagTypeString) {
        case 'language:':
          languageTags =
              tagNames.map((name) => Tag(name, TagType.language)).toList();
          break;
        case 'parody:':
          parodyTags =
              tagNames.map((name) => Tag(name, TagType.parody)).toList();
          break;
        case 'character:':
          characterTags =
              tagNames.map((name) => Tag(name, TagType.character)).toList();
          break;
        case 'group:':
          groupTags = tagNames.map((name) => Tag(name, TagType.group)).toList();
          break;
        case 'artist:':
          artistTags =
              tagNames.map((name) => Tag(name, TagType.artist)).toList();
          break;
        case 'female:':
          femaleTags =
              tagNames.map((name) => Tag(name, TagType.female)).toList();
          break;
        case 'male:':
          maleTags = tagNames.map((name) => Tag(name, TagType.male)).toList();
          break;
        case 'mixed:':
          mixedTags = tagNames.map((name) => Tag(name, TagType.mixed)).toList();
          break;
        case 'other:':
          otherTags = tagNames.map((name) => Tag(name, TagType.other)).toList();
          break;
      }
    }

    category = switch (document.querySelector('.cs')!.text) {
      "Doujinshi" => Category.doujinshi,
      "Manga" => Category.manga,
      "Artist CG" => Category.artistCG,
      "Game CG" => Category.gameCG,
      "Western" => Category.western,
      "Non-H" => Category.nonH,
      "Image Set" => Category.imageSet,
      "Cosplay" => Category.cosplay,
      "Asian Porn" => Category.asianPorn,
      "Misc" => Category.misc,
      _ => throw Exception('Unknown category')
    };

    final gddDiv = document.querySelector('#gdd')!;
    final gddTRs = gddDiv.children.first.children.first.children;
    for (final gddTR in gddTRs) {
      if (gddTR.children.first.text == 'Language:') {
        language = gddTR.children[1].text;
        break;
      }
    }

    final gdtDiv = document.querySelector('#gdt')!;
    for (final a in gdtDiv.children) {
      final href = a.attributes['href'];
      final thumbDiv = a.children.first;
      final style = thumbDiv.attributes['style'] ?? '';
      final widthMatch = RegExp(r'width:(\d+)px').firstMatch(style)!;
      final heightMatch = RegExp(r'height:(\d+)px').firstMatch(style)!;
      final urlMatch = RegExp(r'url\(([^)]+)\)').firstMatch(style)!;
      final offsetMatch =
          RegExp(r'background:[^;]* (-?\d+)px').firstMatch(style)!;

      final width = double.parse(widthMatch.group(1)!);
      final height = double.parse(heightMatch.group(1)!);
      final imageUrl = urlMatch.group(1)!;
      final offsetX = double.parse(offsetMatch.group(1)!);

      previewImageMetas.add(
        ThumbMeta(
          width: width,
          height: height,
          url: imageUrl,
          offsetX: offsetX,
          href: href ?? '',
        ),
      );
    }

    final pttTable = document.querySelector('.ptt')!;
    final totalPagesCount = int.parse(pttTable
        .children
        .first
        .children
        .first
        .children[pttTable.children.first.children.first.children.length - 2]
        .children
        .first
        .text);

    return (
      title,
      subtitle,
      languageTags,
      parodyTags,
      characterTags,
      artistTags,
      groupTags,
      femaleTags,
      maleTags,
      mixedTags,
      otherTags,
      category,
      language,
      previewImageMetas,
      totalPagesCount,
    );
  } catch (e) {
    throw ('Error fetching gallery info: $e');
  }
}
