import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/global_settings_store.dart';
import 'package:flutter_hentai_viewer/nhentai/components/jump_dialog.dart';
import 'package:flutter_hentai_viewer/nhentai/gallery.dart';
import 'package:flutter_hentai_viewer/utils.dart';

class ReadingPage extends StatefulWidget {
  const ReadingPage(this.gallery, this.readingImageUrls, this.initPageIndex,
      {super.key});

  final Gallery gallery;
  final List<String> readingImageUrls;
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
        '${currentPageIndex + 1} / ${widget.readingImageUrls.length}';
  }

  late final ExtendedPageController pageController;
  final paginationTextController = TextEditingController();
  late int currentPageIndex;

  void jumpTo(int index) async {
    widget.readingImageUrls
        .sublist(
            index,
            index + globalSettingsStore.preloadImageCount <
                    widget.readingImageUrls.length
                ? (index + globalSettingsStore.preloadImageCount)
                : null)
        .map((url) => ExtendedNetworkImageProvider(proxy(url), cache: true))
        .forEach((provider) => precacheImage(provider, context));
    await pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    widget.readingImageUrls
        .sublist(
            widget.initPageIndex,
            widget.initPageIndex + globalSettingsStore.preloadImageCount <
                    widget.readingImageUrls.length
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
                                        widget.readingImageUrls.length,
                                    currentPageIndex: currentPageIndex + 1,
                                    jumpTo: jumpTo));
                          },
                          readOnly: true,
                          textAlign: TextAlign.center,
                          controller: paginationTextController),
                    )),
                Expanded(
                    flex: 1,
                    child:
                        (currentPageIndex + 1 == widget.readingImageUrls.length)
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
              if (currentPageIndex < widget.readingImageUrls.length - 1) {
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
                      '${currentPageIndex + 1} / ${widget.readingImageUrls.length}';
                });
              },
              itemCount: widget.readingImageUrls.length,
              itemBuilder: (context, index) => ExtendedImage.network(
                    proxy(widget.readingImageUrls[index]),
                    fit: BoxFit.contain,
                    mode: ExtendedImageMode.gesture,
                  )),
        ));
  }
}
