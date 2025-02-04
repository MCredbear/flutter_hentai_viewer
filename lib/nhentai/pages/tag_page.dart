import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/generated/l10n.dart';
import 'package:flutter_hentai_viewer/global_settings_store.dart';
import 'package:flutter_hentai_viewer/nhentai/components/gallery_card.dart';
import 'package:flutter_hentai_viewer/nhentai/components/jump_dialog.dart';
import 'package:flutter_hentai_viewer/nhentai/tag.dart';
import 'package:flutter_hentai_viewer/nhentai/utils.dart';
import 'package:flutter_hentai_viewer/nhentai/gallery.dart';
import 'package:flutter_hentai_viewer/nhentai/components/menu_drawer.dart';
import 'package:toastification/toastification.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;

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
    final response = await http.get(Uri.parse(proxy(
        '$hostUrl/${widget.keyTag.tagType.name}/${widget.keyTag.name.replaceAll(' ', '-')}/?page=$pageIndex')));
    // final response = await http.get(Uri.parse(proxy(
    //     '$hostUrl/search/?q=${tagFilterStore.tags.where((tag) => tag.tagState == TagState.banned || tag.tagState == TagState.required).map((tag) => '${tag.tagState == TagState.banned ? '-' : ''}${{
    //           TagType.tag: 'tag',
    //           TagType.artist: 'artists',
    //           TagType.character: 'characters',
    //           TagType.parody: 'parodies',
    //           TagType.group: 'groups',
    //         }[tag.tagType]}%3A"${tag.name.replaceAll(' ', '+')}"').join('+')}${tagFilterStore.tags.where((tag) => tag.tagState == TagState.banned || tag.tagState == TagState.required).isNotEmpty ? '+' : ''}${widget.keyTag.name.replaceAll(' ', '+')}&page=$pageIndex')));
    final document = html_parser.parse(response.body);
    final galleryContainerDivs =
        document.querySelectorAll('.container.index-container');
    final paginationSection = document.querySelector('.pagination');
    if (galleryContainerDivs.isNotEmpty) {
      final galleries = [];
      for (final galleryContainerDiv in galleryContainerDivs) {
        galleries.addAll(galleryContainerDiv.querySelectorAll('.gallery'));
      }
      setState(() {
        if (!globalSettingsStore.scrollUpToLoadMore) {
          this.galleries = galleries.map((gallery) {
            final coverA = gallery.querySelector('.cover');
            final id = int.parse(coverA!.attributes['href']!.split('/')[2]);
            final captionDiv = gallery.querySelector('.caption');
            final title = captionDiv!.text;
            final lazyLoadImg = gallery.querySelector('.lazyload');
            final coverImageUrl = lazyLoadImg!.attributes['data-src']!;
            final tagIds = gallery.attributes['data-tags']!
                .split(' ')
                .map((e) => int.parse(e))
                .toList()
                .cast<int>();
            return Gallery(id, title, coverImageUrl, tagIds);
          }).toList();
        } else {
          if (pageIndex == 1) {
            this.galleries = [];
          }
          this.galleries!.addAll(galleries.map((gallery) {
                final coverA = gallery.querySelector('.cover');
                final id = int.parse(coverA!.attributes['href']!.split('/')[2]);
                final captionDiv = gallery.querySelector('.caption');
                final title = captionDiv!.text;
                final lazyLoadImg = gallery.querySelector('.lazyload');
                final coverImageUrl = lazyLoadImg!.attributes['data-src']!;
                final tagIds = gallery.attributes['data-tags']!
                    .split(' ')
                    .map((e) => int.parse(e))
                    .toList()
                    .cast<int>();
                return Gallery(id, title, coverImageUrl, tagIds);
              }).toList());
        }
      });

      if (paginationSection == null) {
        setState(() {
          currentPageIndex = 1;
          lastPageIndex = 1;
          paginationTextController.text =
              '$currentPageIndex / ${lastPageIndex ?? 1}';
        });
      } else {
        setState(() {
          final pageCurrentA =
              paginationSection.querySelector('.page.current')!;
          currentPageIndex = int.parse(pageCurrentA.text);
          final lastA = paginationSection.querySelector('.last');
          lastPageIndex = (lastA != null)
              ? int.parse(lastA.attributes['href']!.split('page=')[1])
              : currentPageIndex;
          paginationTextController.text =
              '$currentPageIndex / ${lastPageIndex ?? 1}';
        });
      }
    } else {
      toastification.show(
          title: Text(L10n.current.networkError),
          autoCloseDuration: const Duration(seconds: 3));
    }
  }
}
