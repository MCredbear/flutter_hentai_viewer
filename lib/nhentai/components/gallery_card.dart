import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/flags.dart';
import 'package:flutter_hentai_viewer/nhentai/gallery.dart';
import 'package:flutter_hentai_viewer/nhentai/pages/gallery_page.dart';
import 'package:flutter_hentai_viewer/nhentai/utils.dart';

class GalleryCard extends StatelessWidget {
  const GalleryCard(
    this.gallery, {
    super.key,
  });

  final Gallery gallery;

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
              ExtendedImage.network(
                proxy(gallery.coverImageUrl),
                loadStateChanged: (state) {
                  switch (state.extendedImageLoadState) {
                    case LoadState.loading:
                      return LinearProgressIndicator(
                        value: (state.loadingProgress?.cumulativeBytesLoaded ??
                                0) /
                            (state.loadingProgress?.expectedTotalBytes ??
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
                child: RichText(
                    text: TextSpan(children: [
                  WidgetSpan(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Flag(gallery.language),
                  )),
                  TextSpan(text: gallery.title)
                ])),
              )
            ],
          ),
          Positioned.fill(
              child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GalleryPage(gallery)));
              },
            ),
          ))
        ],
      ),
    );
  }
}
