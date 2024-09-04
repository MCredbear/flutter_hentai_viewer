import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/nhentai/gallery.dart';
import 'package:flutter_hentai_viewer/nhentai/pages/reading_page.dart';
import 'package:flutter_hentai_viewer/nhentai/tag.dart';
import 'package:flutter_hentai_viewer/nhentai/utils.dart';
import 'package:toastification/toastification.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:waterfall_flow/waterfall_flow.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage(this.gallery, {super.key});

  final Gallery gallery;

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  late final String title;
  late final String subtitle;

  late final List<Tag> parodyTags;
  late final List<Tag> characterTags;
  late final List<Tag> tagTags;
  late final List<Tag> artistTags;
  late final List<Tag> groupTags;
  late final List<Tag> languageTags;
  late final List<Tag> categoryTags;

  late final List<String> previewImageUrls;

  bool loaded = false;

  @override
  void initState() {
    super.initState();
    getGalleryInfo(widget.gallery.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => getGalleryInfo(widget.gallery.id),
              icon: const Icon(Icons.more_vert))
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: !loaded
            ? []
            : [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Card(
                            margin: const EdgeInsets.all(20),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: ExtendedImage.network(
                              proxy(widget.gallery.coverImageUrl),
                              fit: BoxFit.contain,
                            ))),
                    Expanded(
                        child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child:
                              Text(title, style: const TextStyle(fontSize: 18)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20, left: 20, right: 20),
                          child: Text(subtitle,
                              style: const TextStyle(fontSize: 14)),
                        )
                      ],
                    ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      parodyTags.isNotEmpty
                          ? RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text: '原作: ',
                                  style: const TextStyle(fontSize: 16),
                                  children: (() => parodyTags
                                      .map((parodyTag) => WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2, right: 2),
                                            child: RawChip(
                                                onPressed: () {},
                                                label: Text(parodyTag.name,
                                                    textAlign:
                                                        TextAlign.center)),
                                          )))
                                      .toList()).call()))
                          : Container(),
                      characterTags.isNotEmpty
                          ? RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text: '角色: ',
                                  style: const TextStyle(fontSize: 16),
                                  children: (() => characterTags
                                      .map((characterTag) => WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: RawChip(
                                                onPressed: () {},
                                                label: Text(characterTag.name,
                                                    textAlign:
                                                        TextAlign.center)),
                                          )))
                                      .toList()).call()))
                          : Container(),
                      tagTags.isNotEmpty
                          ? RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text: '标签: ',
                                  style: const TextStyle(fontSize: 16),
                                  children: (() => tagTags
                                      .map((tagTag) => WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: RawChip(
                                                onPressed: () {},
                                                label: Text(tagTag.name,
                                                    textAlign:
                                                        TextAlign.center)),
                                          )))
                                      .toList()).call()))
                          : Container(),
                      artistTags.isNotEmpty
                          ? RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text: '作者: ',
                                  style: const TextStyle(fontSize: 16),
                                  children: (() => artistTags
                                      .map((artistTag) => WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: RawChip(
                                                onPressed: () {},
                                                label: Text(artistTag.name,
                                                    textAlign:
                                                        TextAlign.center)),
                                          )))
                                      .toList()).call()))
                          : Container(),
                      groupTags.isNotEmpty
                          ? RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text: '社团: ',
                                  style: const TextStyle(fontSize: 16),
                                  children: (() => groupTags
                                      .map((groupTag) => WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: RawChip(
                                                onPressed: () {},
                                                label: Text(groupTag.name,
                                                    textAlign:
                                                        TextAlign.center)),
                                          )))
                                      .toList()).call()))
                          : Container(),
                      languageTags.isNotEmpty
                          ? RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text: '语言: ',
                                  style: const TextStyle(fontSize: 16),
                                  children: (() => languageTags
                                      .map((languageTag) => WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: RawChip(
                                                onPressed: () {},
                                                label: Text(languageTag.name,
                                                    textAlign:
                                                        TextAlign.center)),
                                          )))
                                      .toList()).call()))
                          : Container(),
                      categoryTags.isNotEmpty
                          ? RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text: '类别: ',
                                  style: const TextStyle(fontSize: 16),
                                  children: (() => categoryTags
                                      .map((categoryTag) => WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: RawChip(
                                                onPressed: () {},
                                                label: Text(categoryTag.name,
                                                    textAlign:
                                                        TextAlign.center)),
                                          )))
                                      .toList()).call()))
                          : Container(),
                    ],
                  ),
                ),
                WaterfallFlow.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemCount: previewImageUrls.length,
                    itemBuilder: (context, index) => Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ExtendedImage.network(
                                    proxy(previewImageUrls[index]),
                                    cache: true,
                                    loadStateChanged: (state) {
                                      switch (state.extendedImageLoadState) {
                                        case LoadState.loading:
                                          return LinearProgressIndicator(
                                            value: (state.loadingProgress
                                                        ?.cumulativeBytesLoaded ??
                                                    0) /
                                                (state.loadingProgress
                                                        ?.expectedTotalBytes ??
                                                    double.infinity),
                                          );
                                        case LoadState.completed:
                                          return state.completedWidget;
                                        case LoadState.failed:
                                          return const Text(
                                            "加载失败",
                                            textAlign: TextAlign.center,
                                          );
                                      }
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      '${index + 1}',
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                              Positioned.fill(
                                  child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => ReadingPage(
                                                widget.gallery,
                                                previewImageUrls
                                                    .map((url) => url
                                                        .replaceFirst(
                                                            '/t', '/i')
                                                        .replaceFirst(
                                                            't.', '.'))
                                                    .toList(),
                                                index)));
                                  },
                                ),
                              ))
                            ],
                          ),
                        ))
              ],
      ),
    );
  }

  void getGalleryInfo(int galleryId) async {
    final response = await http.get(Uri.parse(proxy('$hostUrl/g/$galleryId/')));
    final document = html_parser.parse(response.body);
    var infoDiv = document.querySelector('#info');
    if (infoDiv != null) {
      final titleHs = infoDiv.querySelectorAll('.title');
      final title = titleHs.first.children.map((span) => span.text).join();
      final subtitle =
          titleHs.lastOrNull?.children.map((span) => span.text).join() ?? '';

      final tagsSection = infoDiv.querySelector('#tags');
      final parodyTags =
          tagsSection!.children[0].children.first.children.map((tagA) {
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
      final characterTags =
          tagsSection.children[1].children.first.children.map((tagA) {
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
      final tagTags =
          tagsSection.children[2].children.first.children.map((tagA) {
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
      final artistTags =
          tagsSection.children[3].children.first.children.map((tagA) {
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
      final groupTags =
          tagsSection.children[4].children.first.children.map((tagA) {
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
      final languageTags =
          tagsSection.children[5].children.first.children.map((tagA) {
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
      final categoryTags =
          tagsSection.children[6].children.first.children.map((tagA) {
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

      final thumbsDiv = document.querySelector('.thumbs')!;
      final lazyloadImgs = thumbsDiv.querySelectorAll('.lazyload');
      final previewImageUrls = lazyloadImgs
          .map((lazyloadImg) => lazyloadImg.attributes['data-src']!)
          .toList();

      setState(() {
        this.title = title;
        this.subtitle = subtitle;

        this.parodyTags = parodyTags;
        this.characterTags = characterTags;
        this.tagTags = tagTags;
        this.artistTags = artistTags;
        this.groupTags = groupTags;
        this.languageTags = languageTags;
        this.categoryTags = categoryTags;

        this.previewImageUrls = previewImageUrls;

        loaded = true;
      });
    } else {
      toastification.show(
          title: const Text('网络错误'),
          autoCloseDuration: const Duration(seconds: 3));
    }
  }
}
