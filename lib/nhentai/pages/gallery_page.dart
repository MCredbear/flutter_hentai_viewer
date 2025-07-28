import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/generated/l10n.dart';
import 'package:flutter_hentai_viewer/nhentai/image_meta.dart';
import 'package:flutter_hentai_viewer/nhentai/gallery.dart';
import 'package:flutter_hentai_viewer/nhentai/pages/reading_page.dart';
import 'package:flutter_hentai_viewer/nhentai/pages/tag_page.dart';
import 'package:flutter_hentai_viewer/nhentai/stores/favorite_store.dart';
import 'package:flutter_hentai_viewer/nhentai/stores/setting_store.dart';
import 'package:flutter_hentai_viewer/nhentai/stores/tag_filter_store.dart';
import 'package:flutter_hentai_viewer/nhentai/tag.dart';
import 'package:flutter_hentai_viewer/utils.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:toastification/toastification.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:flutter_hentai_viewer/nhentai/api/api.dart' as api;

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

  late final List<ImageMeta> previewImageMetas;

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
            Observer(
              builder: (context) => IconButton(
                  onPressed: () {
                    favoriteStore.isFavorite(widget.gallery)
                        ? favoriteStore.remove(widget.gallery)
                        : favoriteStore.add(widget.gallery);
                  },
                  icon: Icon(favoriteStore.isFavorite(widget.gallery)
                      ? Icons.favorite
                      : Icons.favorite_outline)),
            )
          ],
        ),
        body: loaded
            ? NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Card(
                                      margin: const EdgeInsets.all(20),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: AspectRatio(
                                        aspectRatio: widget
                                                .gallery.coverImageMeta.width /
                                            widget
                                                .gallery.coverImageMeta.height,
                                        child: ExtendedImage.network(
                                          proxy(widget
                                              .gallery.coverImageMeta.url),
                                          fit: BoxFit.contain,
                                        ),
                                      ))),
                              Expanded(
                                  child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Text(title,
                                        style: const TextStyle(fontSize: 18)),
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
                                            text: '${L10n.current.parody}: ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.color),
                                            children: (() => parodyTags
                                                .map((parodyTag) => WidgetSpan(
                                                    alignment:
                                                        PlaceholderAlignment
                                                            .middle,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 2,
                                                              right: 2),
                                                      child: RawChip(
                                                          onPressed: () => Navigator
                                                                  .of(context)
                                                              .push(MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      TagPage(
                                                                          parodyTag))),
                                                          label: Text(
                                                              parodyTag.name,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center)),
                                                    )))
                                                .toList()).call()))
                                    : Container(),
                                characterTags.isNotEmpty
                                    ? RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                            text: '${L10n.current.character}: ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.color),
                                            children: (() => characterTags
                                                .map((characterTag) =>
                                                    WidgetSpan(
                                                        alignment:
                                                            PlaceholderAlignment
                                                                .middle,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2),
                                                          child: RawChip(
                                                              onPressed: () => Navigator
                                                                      .of(
                                                                          context)
                                                                  .push(MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          TagPage(
                                                                              characterTag))),
                                                              label: Text(
                                                                  characterTag
                                                                      .name,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center)),
                                                        )))
                                                .toList()).call()))
                                    : Container(),
                                tagTags.isNotEmpty
                                    ? RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                            text: '${L10n.current.tag}: ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.color),
                                            children: (() => tagTags
                                                .map((tagTag) => WidgetSpan(
                                                    alignment:
                                                        PlaceholderAlignment
                                                            .middle,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2),
                                                      child: RawChip(
                                                          onPressed: () => Navigator
                                                                  .of(context)
                                                              .push(MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      TagPage(
                                                                          tagTag))),
                                                          label: Text(
                                                              tagTag.name,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center)),
                                                    )))
                                                .toList()).call()))
                                    : Container(),
                                artistTags.isNotEmpty
                                    ? RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                            text: '${L10n.current.artist}: ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.color),
                                            children: (() => artistTags
                                                .map((artistTag) => WidgetSpan(
                                                    alignment:
                                                        PlaceholderAlignment
                                                            .middle,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2),
                                                      child: RawChip(
                                                          onPressed: () => Navigator
                                                                  .of(context)
                                                              .push(MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      TagPage(
                                                                          artistTag))),
                                                          label: Text(
                                                              artistTag.name,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center)),
                                                    )))
                                                .toList()).call()))
                                    : Container(),
                                groupTags.isNotEmpty
                                    ? RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                            text: '${L10n.current.group}: ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.color),
                                            children: (() => groupTags
                                                .map((groupTag) => WidgetSpan(
                                                    alignment:
                                                        PlaceholderAlignment
                                                            .middle,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2),
                                                      child: RawChip(
                                                          onPressed: () => Navigator
                                                                  .of(context)
                                                              .push(MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      TagPage(
                                                                          groupTag))),
                                                          label: Text(
                                                              groupTag.name,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center)),
                                                    )))
                                                .toList()).call()))
                                    : Container(),
                                languageTags.isNotEmpty
                                    ? RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                            text: '${L10n.current.language}: ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.color),
                                            children: (() => languageTags
                                                .map((languageTag) =>
                                                    WidgetSpan(
                                                        alignment:
                                                            PlaceholderAlignment
                                                                .middle,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2),
                                                          child: RawChip(
                                                              onPressed: () => Navigator
                                                                      .of(
                                                                          context)
                                                                  .push(MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          TagPage(
                                                                              languageTag))),
                                                              label: Text(
                                                                  languageTag
                                                                      .name,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center)),
                                                        )))
                                                .toList()).call()))
                                    : Container(),
                                categoryTags.isNotEmpty
                                    ? RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                            text: '${L10n.current.category}: ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.color),
                                            children: (() => categoryTags
                                                .map((categoryTag) =>
                                                    WidgetSpan(
                                                        alignment:
                                                            PlaceholderAlignment
                                                                .middle,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2),
                                                          child: RawChip(
                                                              onPressed: () => Navigator
                                                                      .of(
                                                                          context)
                                                                  .push(MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          TagPage(
                                                                              categoryTag))),
                                                              label: Text(
                                                                  categoryTag
                                                                      .name,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center)),
                                                        )))
                                                .toList()).call()))
                                    : Container(),
                                Text(
                                    '${L10n.current.pageCount}: ${previewImageMetas.length}',
                                    style: const TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ];
                },
                body: WaterfallFlow.builder(
                    gridDelegate:
                        const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemCount: previewImageMetas.length,
                    itemBuilder: (context, index) => Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 1 / 1.414,
                                        child: ExtendedImage.network(
                                          proxy(previewImageMetas[index].url),
                                          loadStateChanged: (state) {
                                            switch (
                                                state.extendedImageLoadState) {
                                              case LoadState.loading:
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                  ),
                                                );
                                              case LoadState.completed:
                                                return state.completedWidget;
                                              case LoadState.failed:
                                                return Text(
                                                  L10n.current.loadingFailed,
                                                  textAlign: TextAlign.center,
                                                );
                                            }
                                          },
                                        ),
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
                                                    previewImageMetas
                                                        .map((previewImageMeta) =>
                                                            previewImageMeta.url
                                                                .replaceFirst(
                                                                    '/t', '/i')
                                                                .replaceFirst(
                                                                    't.', '.')
                                                                .split('.')
                                                                .sublist(0, 4)
                                                                .join('.'))
                                                        .toList(),
                                                    index)));
                                      },
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          ],
                        )))
            : Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary)));
  }

  void getGalleryInfo(int galleryId) async {
    try {
      final (
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
      ) = await api.galleryInfo(galleryId);
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
        this.previewImageMetas = previewImageMetas;
        loaded = true;
      });
      if (nhentaiSettingsStore.autoUpdateTags) {
        tagFilterStore.updateTags(
          parodyTags +
              characterTags +
              tagTags +
              artistTags +
              groupTags +
              languageTags +
              categoryTags,
        );
      }
    } catch (e) {
      toastification.show(
        title: Text(L10n.current.networkError),
        autoCloseDuration: const Duration(seconds: 3),
      );
      return;
    }
  }
}
