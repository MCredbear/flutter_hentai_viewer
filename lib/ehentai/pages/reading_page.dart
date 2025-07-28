import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/generated/l10n.dart';
import 'package:flutter_hentai_viewer/global_settings_store.dart';
import 'package:flutter_hentai_viewer/ehentai/components/jump_dialog.dart';
import 'package:flutter_hentai_viewer/ehentai/gallery.dart';
import 'package:flutter_hentai_viewer/utils.dart';
import 'package:flutter_hentai_viewer/ehentai/api/api.dart';

class ReadingPage extends StatefulWidget {
  const ReadingPage(this.gallery, this.readingImageHrefs, this.initPageIndex,
      {super.key});

  final Gallery gallery;
  final List<String> readingImageHrefs;
  final int initPageIndex;

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.initPageIndex;
    pageController = ExtendedPageController(initialPage: widget.initPageIndex);
    paginationTextController.text =
        '${currentPageIndex + 1} / ${widget.readingImageHrefs.length}';
  }

  late final ExtendedPageController pageController;
  final paginationTextController = TextEditingController();
  late int currentPageIndex;

  late final List<String?> readingImageUrls =
      List.filled(widget.readingImageHrefs.length, null, growable: false);

  void jumpTo(int index) async {
    for (var i = index;
        i <
            ((index + globalSettingsStore.preloadImageCount <
                    widget.readingImageHrefs.length)
                ? (index + globalSettingsStore.preloadImageCount)
                : widget.readingImageHrefs.length);
        i += 1) {
      if (readingImageUrls[i] == null) {
        thumbHrefToFullImage(widget.readingImageHrefs[i]).then((url) {
          readingImageUrls[i] = url;
          if (mounted) {
            precacheImage(
                ExtendedNetworkImageProvider(
                  proxy(url),
                  cache: true,
                ),
                context);
          }
        });
      } else {
        precacheImage(
            ExtendedNetworkImageProvider(
              proxy(readingImageUrls[i]!),
              cache: true,
            ),
            context);
      }
    }
    await pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    widget.readingImageHrefs
        .sublist(
            widget.initPageIndex,
            widget.initPageIndex + globalSettingsStore.preloadImageCount <
                    widget.readingImageHrefs.length
                ? (widget.initPageIndex + globalSettingsStore.preloadImageCount)
                : null)
        .map((url) => ExtendedNetworkImageProvider(proxy(url), cache: true))
        .forEach((provider) => precacheImage(provider, context));
    return Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: SizedBox(
          height: 50,
          child: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: (currentPageIndex + 1 == 1)
                        ? Container()
                        : IconButton(
                            onPressed: () => jumpTo(currentPageIndex - 1),
                            icon: const Icon(Icons.keyboard_arrow_left))),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: TextField(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => JumpDialog(
                                    lastPageIndex:
                                        widget.readingImageHrefs.length,
                                    currentPageIndex: currentPageIndex + 1,
                                    jumpTo: jumpTo));
                          },
                          readOnly: true,
                          textAlign: TextAlign.center,
                          controller: paginationTextController),
                    )),
                Expanded(
                    flex: 1,
                    child: (currentPageIndex + 1 ==
                            widget.readingImageHrefs.length)
                        ? Container()
                        : IconButton(
                            onPressed: () => jumpTo(currentPageIndex + 1),
                            icon: const Icon(Icons.keyboard_arrow_right))),
              ],
            ),
          ),
        ),
        body: GestureDetector(
          onTapUp: (details) {
            final screenWidth = MediaQuery.of(context).size.width;
            final dx = details.globalPosition.dx;
            if (dx < screenWidth / 3) {
              if (currentPageIndex > 0) {
                jumpTo(currentPageIndex - 1);
              }
            } else if (dx > screenWidth * 2 / 3) {
              if (currentPageIndex < widget.readingImageHrefs.length - 1) {
                jumpTo(currentPageIndex + 1);
              }
            }
          },
          child: ExtendedImageGesturePageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: (index) {
                currentPageIndex = index;
                setState(() {
                  paginationTextController.text =
                      '${currentPageIndex + 1} / ${widget.readingImageHrefs.length}';
                });
              },
              itemCount: widget.readingImageHrefs.length,
              itemBuilder: (context, index) => FutureBuilder(
                  future: readingImageUrls[index] == null
                      ? thumbHrefToFullImage(widget.readingImageHrefs[index])
                          .then((url) {
                          readingImageUrls[index] = url;
                          return url;
                        })
                      : Future.value(readingImageUrls[index]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: TextButton(
                        onPressed: () {
                          setState(() {
                            readingImageUrls[index] = null;
                          });
                        },
                        child: Text(
                          '${L10n.current.loadingFailed}\n${L10n.current.tapToRetry}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color),
                        ),
                      ));
                    } else {
                      return ExtendedImage.network(
                        proxy(snapshot.data!),
                        fit: BoxFit.contain,
                        mode: ExtendedImageMode.gesture,
                      );
                    }
                  })),
        ));
  }
}
