import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/generated/l10n.dart';
import 'package:flutter_hentai_viewer/global_settings_store.dart';
import 'package:flutter_hentai_viewer/nhentai/api/api.dart';
import 'package:flutter_hentai_viewer/nhentai/components/gallery_card.dart';
import 'package:flutter_hentai_viewer/nhentai/components/jump_dialog.dart';
import 'package:flutter_hentai_viewer/nhentai/stores/history_store.dart';
import 'package:flutter_hentai_viewer/nhentai/stores/setting_store.dart';
import 'package:flutter_hentai_viewer/nhentai/tag.dart';
import 'package:flutter_hentai_viewer/nhentai/gallery.dart';
import 'package:flutter_hentai_viewer/nhentai/components/menu_drawer.dart';
import 'package:toastification/toastification.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class TagPage extends StatefulWidget {
  const TagPage(
    this.keyTag, {
    super.key,
  });

  final Tag keyTag;

  @override
  State<TagPage> createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  @override
  void initState() {
    super.initState();
    getGalleries(currentPageIndex);
    if (globalSettingsStore.scrollUpToLoadMore) {
      scrollController.addListener(scrollListener);
    }
  }

  List<Gallery>? galleries;

  int currentPageIndex = 1;
  int? lastPageIndex;
  final paginationTextController = TextEditingController();

  final scrollController = ScrollController();
  void scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100 &&
        currentPageIndex < (lastPageIndex ?? 1)) {
      getGalleries(currentPageIndex + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.keyTag.name),
          actions: [
            BackButton(
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        drawer: MenuDrawer(() => getGalleries(1)),
        bottomNavigationBar: (lastPageIndex == null || lastPageIndex == 1)
            ? null
            : SizedBox(
                height: 50,
                child: BottomAppBar(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: (currentPageIndex == 1 ||
                                  globalSettingsStore.scrollUpToLoadMore)
                              ? Container()
                              : IconButton(
                                  onPressed: () {
                                    getGalleries(currentPageIndex - 1);
                                  },
                                  icon: const Icon(Icons.keyboard_arrow_left))),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: TextField(
                                onTap: globalSettingsStore.scrollUpToLoadMore
                                    ? null
                                    : () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => JumpDialog(
                                                lastPageIndex: lastPageIndex!,
                                                currentPageIndex:
                                                    currentPageIndex,
                                                jumpTo: getGalleries));
                                      },
                                readOnly: true,
                                textAlign: TextAlign.center,
                                controller: paginationTextController),
                          )),
                      Expanded(
                          flex: 1,
                          child: (currentPageIndex == lastPageIndex ||
                                  globalSettingsStore.scrollUpToLoadMore)
                              ? Container()
                              : IconButton(
                                  onPressed: () {
                                    getGalleries(currentPageIndex + 1);
                                  },
                                  icon:
                                      const Icon(Icons.keyboard_arrow_right))),
                    ],
                  ),
                ),
              ),
        body: Center(
          child: (galleries == null)
              ? const CircularProgressIndicator()
              : WaterfallFlow.builder(
                  controller: scrollController,
                  gridDelegate:
                      const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemCount: galleries!.length,
                  itemBuilder: (context, index) =>
                      GalleryCard(galleries![index])),
        ));
  }

  void getGalleries(int pageIndex) async {
    try {
      final (galleries, currentPageIndex, lastPageIndex) =
          await searchBySingleTag(widget.keyTag, pageIndex);
      if (nhentaiSettingsStore.showHistoryMode == ShowHistoryMode.doNotShow) {
        galleries.removeWhere((gallery) => historyStore.isInHistory(gallery));
      }
      setState(() {
        this.galleries = galleries;
        this.currentPageIndex = currentPageIndex;
        this.lastPageIndex = lastPageIndex;
        paginationTextController.text = '$currentPageIndex / $lastPageIndex';
      });
    } catch (e) {
      setState(() {
        galleries = [];
        currentPageIndex = 1;
        lastPageIndex = 1;
        paginationTextController.text = '$currentPageIndex / $lastPageIndex';
      });

      toastification.show(
          title: Text(L10n.current.networkError),
          autoCloseDuration: const Duration(seconds: 3));
    }
  }
}
