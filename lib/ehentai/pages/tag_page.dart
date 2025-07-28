import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/generated/l10n.dart';
import 'package:flutter_hentai_viewer/global_settings_store.dart';
import 'package:flutter_hentai_viewer/ehentai/api/api.dart';
import 'package:flutter_hentai_viewer/ehentai/components/gallery_card.dart';
import 'package:flutter_hentai_viewer/ehentai/stores/history_store.dart';
import 'package:flutter_hentai_viewer/ehentai/stores/setting_store.dart';
import 'package:flutter_hentai_viewer/ehentai/tag.dart';
import 'package:flutter_hentai_viewer/ehentai/gallery.dart';
import 'package:flutter_hentai_viewer/ehentai/components/menu_drawer.dart';
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
    getGalleries();
    if (globalSettingsStore.scrollUpToLoadMore) {
      scrollController.addListener(scrollListener);
    }
  }

  List<Gallery>? galleries;

  bool hasPreviousPage = false;
  bool hasNextPage = false;

  (int? previousGalleryId, int? nextGalleryId) previousSearchParams =
      (null, null);

  final scrollController = ScrollController();
  void scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100 &&
        hasNextPage) {
      if (hasNextPage) {
        getGalleries(nextGalleryId: galleries?.last.id);
      }
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
        drawer: const MenuDrawer(),
        onDrawerChanged: (isOpened) async {
          if (!isOpened) {
            setState(() {
              galleries = null;
            });
            if (globalSettingsStore.scrollUpToLoadMore) {
              await getGalleries();
              scrollController.jumpTo(0);
            } else {
              getGalleries(
                  prevGalleryId: previousSearchParams.$1,
                  nextGalleryId: previousSearchParams.$2);
            }
          }
        },
        bottomNavigationBar: ((hasPreviousPage || hasNextPage) &&
                !globalSettingsStore.scrollUpToLoadMore)
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
                          child: hasPreviousPage
                              ? Container()
                              : IconButton(
                                  onPressed: () async {
                                    await getGalleries(
                                        prevGalleryId: galleries?.first.id);
                                    scrollController.jumpTo(0);
                                  },
                                  icon: const Icon(Icons.keyboard_arrow_left))),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                          flex: 1,
                          child: hasNextPage
                              ? Container()
                              : IconButton(
                                  onPressed: () async {
                                    await getGalleries(
                                        nextGalleryId: galleries?.last.id);
                                    scrollController.jumpTo(0);
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
              : RefreshIndicator(
                  onRefresh: () async {
                    await getGalleries(
                        prevGalleryId: previousSearchParams.$1,
                        nextGalleryId: previousSearchParams.$2);
                  },
                  child: WaterfallFlow.builder(
                    controller: scrollController,
                    gridDelegate:
                        const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: galleries!.length,
                    itemBuilder: (context, index) =>
                        GalleryCard(galleries![index]),
                  ),
                ),
        ));
  }

  Future<void> getGalleries({int? prevGalleryId, int? nextGalleryId}) async {
    try {
      previousSearchParams = (prevGalleryId, nextGalleryId);
      final (galleries, hasPreviousPage, hasNextPage) = await searchGalleries(
          categories: ehentaiSettingsStore.enabledCategories,
          keyword:
              '${widget.keyTag.tagType.name}:"${widget.keyTag.name.split('|').first.trim()}%24"'
                  .replaceAll(' ', '+'),
          prevGalleryId: prevGalleryId,
          nextGalleryId: nextGalleryId);
      if (ehentaiSettingsStore.showHistoryMode == ShowHistoryMode.doNotShow) {
        galleries.removeWhere((gallery) => historyStore.isInHistory(gallery));
      }
      setState(() {
        this.galleries = globalSettingsStore.scrollUpToLoadMore
            ? (this.galleries ?? <Gallery>[]) + galleries
            : galleries;
        this.hasPreviousPage = hasPreviousPage;
        this.hasNextPage = hasNextPage;
      });
    } catch (e) {
      setState(() {
        galleries = [];
        hasPreviousPage = false;
        hasNextPage = false;
      });

      toastification.show(
          title: Text(L10n.current.networkError),
          autoCloseDuration: const Duration(seconds: 3));
    }
  }
}
