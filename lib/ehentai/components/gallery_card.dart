import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/ehentai/gallery.dart';
import 'package:flutter_hentai_viewer/ehentai/pages/gallery_page.dart';
import 'package:flutter_hentai_viewer/ehentai/stores/favorite_store.dart';
import 'package:flutter_hentai_viewer/ehentai/stores/setting_store.dart';
import 'package:flutter_hentai_viewer/ehentai/stores/tag_filter_store.dart';
import 'package:flutter_hentai_viewer/ehentai/stores/history_store.dart';
import 'package:flutter_hentai_viewer/utils.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class GalleryCard extends StatefulWidget {
  const GalleryCard(
    this.gallery, {
    super.key,
  });

  final Gallery gallery;

  @override
  State<GalleryCard> createState() => _GalleryCardState();
}

class _GalleryCardState extends State<GalleryCard> {
  late bool isMasked =
      widget.gallery.tags.any(tagFilterStore.bannedTags.contains);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Observer(
        builder: (context) => Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: widget.gallery.coverImageMeta.width /
                      widget.gallery.coverImageMeta.height,
                  child: ExtendedImage.network(
                    proxy(widget.gallery.coverImageMeta.url),
                    loadStateChanged: (state) {
                      switch (state.extendedImageLoadState) {
                        case LoadState.loading:
                          return Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          );
                        case LoadState.completed:
                          return state.completedWidget;
                        case LoadState.failed:
                          return const Icon(Icons.broken_image, size: 64);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: widget.gallery.title,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface))
                  ])),
                )
              ],
            ),
            if (ehentaiSettingsStore.historyMode != HistoryMode.disabled &&
                ehentaiSettingsStore.showHistoryMode !=
                    ShowHistoryMode.showNormally &&
                historyStore.isInHistory(widget.gallery))
              Positioned(
                  top: 5,
                  right: 5,
                  child: Icon(Icons.beenhere,
                      shadows: [
                        Shadow(
                            offset: const Offset(0, 1),
                            blurRadius: 2,
                            color: Theme.of(context)
                                .colorScheme
                                .shadow
                                .withValues(alpha: 0.5))
                      ],
                      color: Theme.of(context).colorScheme.tertiary)),
            if (favoriteStore.isFavorite(widget.gallery))
              Positioned(
                  top: 5,
                  right: ehentaiSettingsStore.showHistoryMode ==
                              ShowHistoryMode.addAPin &&
                          historyStore.isInHistory(widget.gallery) &&
                          ehentaiSettingsStore.showFavoriteMode ==
                              ShowFavoriteMode.addAPin
                      ? 30
                      : 5,
                  child: Icon(Icons.favorite,
                      shadows: [
                        Shadow(
                            offset: const Offset(0, 1),
                            blurRadius: 2,
                            color: Theme.of(context)
                                .colorScheme
                                .shadow
                                .withValues(alpha: 0.5))
                      ],
                      color: Theme.of(context).colorScheme.tertiary)),
            if (isMasked)
              Positioned.fill(
                  child: Container(color: Colors.black.withValues(alpha: 0.5))),
            Positioned.fill(
                child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  if (isMasked) {
                    setState(() {
                      isMasked = false;
                    });
                  } else {
                    if (ehentaiSettingsStore.historyMode !=
                        HistoryMode.disabled) {
                      historyStore.add(widget.gallery);
                    }
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GalleryPage(widget.gallery)));
                  }
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
