import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/ehentai/thumb_meta.dart';
import 'package:flutter_hentai_viewer/generated/l10n.dart';
import 'package:flutter_hentai_viewer/ehentai/gallery.dart';
import 'package:flutter_hentai_viewer/ehentai/pages/reading_page.dart';
import 'package:flutter_hentai_viewer/ehentai/pages/tag_page.dart';
import 'package:flutter_hentai_viewer/ehentai/stores/favorite_store.dart';
import 'package:flutter_hentai_viewer/ehentai/stores/setting_store.dart';
import 'package:flutter_hentai_viewer/ehentai/stores/tag_filter_store.dart';
import 'package:flutter_hentai_viewer/ehentai/tag.dart';
import 'package:flutter_hentai_viewer/ehentai/utils.dart';
import 'package:flutter_hentai_viewer/utils.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:toastification/toastification.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:flutter_hentai_viewer/ehentai/api/api.dart' as api;

class GalleryPage extends StatefulWidget {
  const GalleryPage(this.gallery, {super.key});

  final Gallery gallery;

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  late final String title;
  late final String subtitle;

  late final List<Tag> languageTags;
  late final List<Tag> parodyTags;
  late final List<Tag> characterTags;
  late final List<Tag> artistTags;
  late final List<Tag> groupTags;
  late final List<Tag> femaleTags;
  late final List<Tag> maleTags;
  late final List<Tag> mixedTags;
  late final List<Tag> otherTags;

  late final Category category;
  late final String language;

  late List<ThumbMeta> previewImageMetas;

  int index = 0;
  int? totalPagesCount;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    getGalleryInfo(widget.gallery);
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
                                  ),
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
                                                  ?.color,
                                            ),
                                            children: (() => languageTags
                                                .map((languageTag) =>
                                                    WidgetSpan(
                                                        alignment:
                                                            PlaceholderAlignment
                                                                .middle,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 2,
                                                                  right: 2),
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
                                                  ?.color,
                                            ),
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
                                                  ?.color,
                                            ),
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
                                                  ?.color,
                                            ),
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
                                                  ?.color,
                                            ),
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
                                femaleTags.isNotEmpty
                                    ? RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                            text: '${L10n.current.female}: ',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.color,
                                            ),
                                            children: (() => femaleTags
                                                .map((femaleTag) => WidgetSpan(
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
                                                                          femaleTag))),
                                                          label: Text(
                                                              femaleTag.name,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center)),
                                                    )))
                                                .toList()).call()))
                                    : Container(),
                                maleTags.isNotEmpty
                                    ? RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                            text: '${L10n.current.male}: ',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.color,
                                            ),
                                            children: (() => maleTags
                                                .map((maleTag) => WidgetSpan(
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
                                                                          maleTag))),
                                                          label: Text(
                                                              maleTag.name,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center)),
                                                    )))
                                                .toList()).call()))
                                    : Container(),
                                mixedTags.isNotEmpty
                                    ? RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                            text: '${L10n.current.mixed}: ',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.color,
                                            ),
                                            children: (() => mixedTags
                                                .map((mixedTag) => WidgetSpan(
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
                                                                          mixedTag))),
                                                          label: Text(
                                                              mixedTag.name,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center)),
                                                    )))
                                                .toList()).call()))
                                    : Container(),
                                otherTags.isNotEmpty
                                    ? RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                            text: '${L10n.current.other}: ',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.color,
                                            ),
                                            children: (() => otherTags
                                                .map((otherTag) => WidgetSpan(
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
                                                                          otherTag))),
                                                          label: Text(
                                                              otherTag.name,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center)),
                                                    )))
                                                .toList()).call()))
                                    : Container(),
                                Text(
                                  '${L10n.current.category}: ${category.string}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                    '${L10n.current.pageCount}: ${previewImageMetas.length}',
                                    style: const TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
                                        child: ClipRect(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AspectRatio(
                                                aspectRatio:
                                                    previewImageMetas[index]
                                                            .width /
                                                        previewImageMetas[index]
                                                            .height,
                                                child: ExtendedImage.network(
                                                  proxy(previewImageMetas[index]
                                                      .url),
                                                  loadStateChanged: (state) {
                                                    switch (state
                                                        .extendedImageLoadState) {
                                                      case LoadState.loading:
                                                        return Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary,
                                                          ),
                                                        );
                                                      case LoadState.completed:
                                                        return ExtendedRawImage(
                                                          fit: BoxFit.fill,
                                                          alignment:
                                                              AlignmentGeometry
                                                                  .topLeft,
                                                          image: state
                                                              .extendedImageInfo
                                                              ?.image,
                                                          width:
                                                              previewImageMetas[
                                                                      index]
                                                                  .width,
                                                          height:
                                                              previewImageMetas[
                                                                      index]
                                                                  .height,
                                                          sourceRect: Rect.fromLTWH(
                                                              -previewImageMetas[
                                                                      index]
                                                                  .offsetX,
                                                              0,
                                                              previewImageMetas[
                                                                      index]
                                                                  .width,
                                                              previewImageMetas[
                                                                      index]
                                                                  .height),
                                                        );
                                                      case LoadState.failed:
                                                        return Text(
                                                          L10n.current
                                                              .loadingFailed,
                                                          textAlign:
                                                              TextAlign.center,
                                                        );
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
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
                                                        .map(
                                                            (previewImageMeta) =>
                                                                previewImageMeta
                                                                    .href)
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
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                      value: totalPagesCount != null
                          ? index / totalPagesCount!
                          : null,
                      color: Theme.of(context).colorScheme.secondary),
                  Text(
                    '${L10n.current.loading}: $index / ${totalPagesCount ?? '?'}',
                    textScaler: const TextScaler.linear(1.5),
                  ),
                ],
              )));
  }

  void getGalleryInfo(Gallery gallery) async {
    try {
      final (
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
      ) = await api.galleryInfo(gallery, pageIndex: index);

      this.title = title;
      this.subtitle = subtitle;
      this.languageTags = languageTags;
      this.parodyTags = parodyTags;
      this.characterTags = characterTags;
      this.artistTags = artistTags;
      this.groupTags = groupTags;
      this.femaleTags = femaleTags;
      this.maleTags = maleTags;
      this.mixedTags = mixedTags;
      this.otherTags = otherTags;
      this.category = category;
      this.language = language;
      this.previewImageMetas = previewImageMetas;

      setState(() {
        this.totalPagesCount = totalPagesCount;
      });

      if (ehentaiSettingsStore.autoUpdateTags) {
        tagFilterStore.updateTags(languageTags +
            parodyTags +
            characterTags +
            artistTags +
            groupTags +
            femaleTags +
            maleTags +
            otherTags);
      }

      while (totalPagesCount > index + 1) {
        index += 1;
        final (
          _,
          _,
          _,
          _,
          _,
          _,
          _,
          _,
          _,
          _,
          _,
          _,
          _,
          previewImageMetas,
          _,
        ) = await api.galleryInfo(gallery, pageIndex: index);

        this.previewImageMetas = this.previewImageMetas + previewImageMetas;
      }

      setState(() {
        loaded = true;
      });
    } catch (e) {
      toastification.show(
        title: Text(L10n.current.networkError),
        autoCloseDuration: const Duration(seconds: 3),
      );
      return;
    }
  }
}
