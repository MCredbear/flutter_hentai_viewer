import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/nhentai/gallery.dart';
import 'package:flutter_hentai_viewer/nhentai/utils.dart';

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

  @override
  Widget build(BuildContext context) {
    () async {
      widget.readingImageUrls
          .map((url) => ExtendedNetworkImageProvider(proxy(url), cache: true))
          .forEach((provider) => precacheImage(provider, context));
    }.call();
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
                            onPressed: () async {
                              await pageController.animateToPage(
                                  currentPageIndex - 1,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.linear);
                            },
                            icon: const Icon(Icons.keyboard_arrow_left))),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: TextField(
                          onTap: () {
                            /// TODO: add a jump dialog
                          },
                          readOnly: true,
                          textAlign: TextAlign.center,
                          controller: paginationTextController),
                    )),
                Expanded(
                    flex: 1,
                    child: (currentPageIndex + 1 ==
                            widget.readingImageUrls.length)
                        ? Container()
                        : IconButton(
                            onPressed: () async {
                              await pageController.animateToPage(
                                  currentPageIndex + 1,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.linear);
                            },
                            icon: const Icon(Icons.keyboard_arrow_right))),
              ],
            ),
          ),
        ),
        body: ExtendedImageGesturePageView.builder(
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
                )));
  }
}
