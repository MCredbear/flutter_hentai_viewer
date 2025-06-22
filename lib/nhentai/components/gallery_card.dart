import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/flags.dart';
import 'package:flutter_hentai_viewer/nhentai/gallery.dart';
import 'package:flutter_hentai_viewer/nhentai/pages/gallery_page.dart';
import 'package:flutter_hentai_viewer/nhentai/stores/tag_filter_store.dart';
import 'package:flutter_hentai_viewer/nhentai/utils.dart';

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
  late bool isMasked = widget.gallery.tagIds
      .where((tagId) => tagFilterStore.bannedTagIds.contains(tagId))
      .isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
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
                    text: TextSpan(
                        children: widget.gallery.languages
                                .map((language) => WidgetSpan(
                                        child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: Flag(language),
                                    )))
                                .toList()
                                .cast<InlineSpan>() +
                            [TextSpan(text: widget.gallery.title)])),
              )
            ],
          ),
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GalleryPage(widget.gallery)));
                }
              },
            ),
          ))
        ],
      ),
    );
  }
}
