import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/generated/l10n.dart';
import 'package:flutter_hentai_viewer/nhentai/gallery.dart';
import 'package:flutter_hentai_viewer/nhentai/pages/reading_page.dart';
import 'package:flutter_hentai_viewer/nhentai/pages/tag_page.dart';
import 'package:flutter_hentai_viewer/nhentai/stores/favorite_store.dart';
import 'package:flutter_hentai_viewer/nhentai/stores/history_store.dart';
import 'package:flutter_hentai_viewer/nhentai/stores/setting_store.dart';
import 'package:flutter_hentai_viewer/nhentai/stores/tag_filter_store.dart';
import 'package:flutter_hentai_viewer/nhentai/tag.dart';
import 'package:flutter_hentai_viewer/nhentai/utils.dart';
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
  late final Gallery gallery;

  bool loaded = false;

  final tagTypeToName = {
    TagType.parody: L10n.current.parody,
    TagType.character: L10n.current.character,
    TagType.tag: L10n.current.tag,
    TagType.artist: L10n.current.artist,
    TagType.group: L10n.current.group,
    TagType.language: L10n.current.language,
    TagType.category: L10n.current.category,
  };

  @override
  void initState() {
    super.initState();
    getGalleryInfo(widget.gallery.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: loaded
              ? [
                  Observer(
                    builder: (context) => IconButton(
                      onPressed: () {
                        favoriteStore.isFavorite(gallery)
                            ? favoriteStore.remove(gallery)
                            : favoriteStore.add(gallery);
                      },
                      icon: Icon(favoriteStore.isFavorite(gallery)
                          ? Icons.favorite
                          : Icons.favorite_outline),
                    ),
                  )
                ]
              : null,
        ),
        body: loaded
            ? NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Card(
                                      margin: const EdgeInsets.all(20),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: AspectRatio(
                                        aspectRatio:
                                            gallery.coverImageMeta!.width /
                                                gallery.coverImageMeta!.height,
                                        child: ExtendedImage.network(
                                          proxy(
                                              '$thumbnailCdn/${gallery.coverImageMeta!.path}'),
                                          fit: BoxFit.contain,
                                        ),
                                      ))),
                              Expanded(
                                  child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Text(gallery.englishTitle ?? '',
                                        style: const TextStyle(fontSize: 18)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 20, left: 20, right: 20),
                                    child: Text(gallery.japaneseTitle ?? '',
                                        style: const TextStyle(fontSize: 14)),
                                  )
                                ],
                              ))
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: tagTypeToName.entries
                                  .where((entry) => gallery.tags
                                      .any((tag) => tag.type == entry.key))
                                  .map((entry) {
                                final tags = gallery.tags
                                    .where((tag) => tag.type == entry.key)
                                    .toList();
                                return RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                      text: '${entry.value}: ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.color),
                                      children: (() => tags
                                          .map((tag) => WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                child: RawChip(
                                                    onPressed: () => Navigator
                                                            .of(context)
                                                        .push(MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    TagPage(
                                                                        tag))),
                                                    label: Text(tag.name ?? '',
                                                        textAlign:
                                                            TextAlign.center)),
                                              )))
                                          .toList()).call()),
                                );
                              }).toList(),
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
                    itemCount: gallery.thumbnailMetas?.length ?? 0,
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
                                          proxy(
                                              '$thumbnailCdn/${gallery.thumbnailMetas![index].path}'),
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
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => ReadingPage(
                                                gallery,
                                                gallery.imageMetas!
                                                    .map((imageMeta) =>
                                                        '$imageCdn/${imageMeta.path}')
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
      final gallery = await api.galleryInfo(galleryId);
      setState(() {
        this.gallery = gallery;
        loaded = true;
      });
      if (nhentaiSettingsStore.autoUpdateTags) {
        tagFilterStore.updateTags(gallery.tags);
      }
      if (nhentaiSettingsStore.historyMode != HistoryMode.disabled) {
        historyStore.add(widget.gallery);
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
