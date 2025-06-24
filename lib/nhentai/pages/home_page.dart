import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/generated/l10n.dart';
import 'package:flutter_hentai_viewer/global_settings_store.dart';
import 'package:flutter_hentai_viewer/nhentai/api/api.dart' as api;
import 'package:flutter_hentai_viewer/nhentai/components/gallery_card.dart';
import 'package:flutter_hentai_viewer/nhentai/components/jump_dialog.dart';
import 'package:flutter_hentai_viewer/nhentai/stores/favorite_store.dart';
import 'package:flutter_hentai_viewer/nhentai/stores/history_store.dart';
import 'package:flutter_hentai_viewer/nhentai/stores/setting_store.dart';
import 'package:flutter_hentai_viewer/nhentai/tag.dart';
import 'package:flutter_hentai_viewer/nhentai/stores/tag_filter_store.dart';
import 'package:flutter_hentai_viewer/nhentai/gallery.dart';
import 'package:flutter_hentai_viewer/nhentai/components/menu_drawer.dart';
import 'package:toastification/toastification.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    () async {
      await nhentaiSettingsStore.read();
      await tagFilterStore.read();
      await favoriteStore.read();
      await historyStore.read();
    }.call().then((_) {
      setState(() {
        isLoading = false;
      });
      getGalleries(currentPageIndex);
      if (globalSettingsStore.scrollUpToLoadMore) {
        scrollController.addListener(scrollListener);
      }
    });
  }

  void getGalleries(int pageIndex) => tagFilterStore.tags
              .where((tag) =>
                  tag.tagState == TagState.banned ||
                  tag.tagState == TagState.required)
              .isEmpty &&
          !searching
      ? getLatestGalleries(pageIndex)
      : searchGalleries(pageIndex);

  bool isLoading = true;

  List<Gallery>? galleries;

  int currentPageIndex = 1;
  int? lastPageIndex;
  final paginationTextController = TextEditingController();

  final searchController = TextEditingController();
  bool searching = false;

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
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: !searching
                  ? const Text("NHentai")
                  : TextField(
                      controller: searchController,
                      decoration:
                          const InputDecoration(label: Icon(Icons.search)),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          getGalleries(1);
                        }
                      },
                    ),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        searching = !searching;
                      });
                      searchController.text = '';
                      getGalleries(1);
                    },
                    icon: Icon(!searching ? Icons.search : Icons.cancel))
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
                                      icon: const Icon(
                                          Icons.keyboard_arrow_left))),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: TextField(
                                    onTap: globalSettingsStore
                                            .scrollUpToLoadMore
                                        ? null
                                        : () {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    JumpDialog(
                                                        lastPageIndex:
                                                            lastPageIndex!,
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
                                      icon: const Icon(
                                          Icons.keyboard_arrow_right))),
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
                          GalleryCard(galleries![index]),
                    ),
            ));
  }

  void getLatestGalleries(int pageIndex) async {
    try {
      final (galleries, currentPageIndex, lastPageIndex) =
          await api.latestUpdateGalleries(pageIndex);
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

  void searchGalleries(int pageIndex) async {
    try {
      final (galleries, currentPageIndex, lastPageIndex) =
          await api.searchGalleries(
              searchController.text,
              tagFilterStore.tags
                  .where((tag) => tag.tagState == TagState.required)
                  .toList(),
              tagFilterStore.tags
                  .where((tag) => tag.tagState == TagState.banned)
                  .toList(),
              pageIndex);
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
