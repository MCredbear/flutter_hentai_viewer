import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/nhentai/components/gallery_card.dart';
import 'package:flutter_hentai_viewer/nhentai/tag.dart';
import 'package:flutter_hentai_viewer/nhentai/utils.dart';
import 'package:flutter_hentai_viewer/nhentai/stores/tag_filter_store.dart';
import 'package:flutter_hentai_viewer/nhentai/gallery.dart';
import 'package:flutter_hentai_viewer/nhentai/components/menu_drawer.dart';
import 'package:toastification/toastification.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;

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
    getGalleries(currentPageIndex);
  }

  void getGalleries(int pageIndex) => tagFilterStore.tags
          .where((tag) =>
              tag.tagState == TagState.banned ||
              tag.tagState == TagState.required)
          .isEmpty
      ? getLatestUpdateGalleries(pageIndex)
      : getSearchGalleries(pageIndex);

  List<Gallery>? galleries;

  int currentPageIndex = 1;
  int? lastPageIndex;
  final paginationTextController = TextEditingController();

  final searchController = TextEditingController();
  bool searching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: !searching
              ? const Text("NHentai")
              : TextField(
                  controller: searchController,
                  decoration: const InputDecoration(label: Icon(Icons.search)),
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
        drawer: const MenuDrawer(),
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
                          child: (currentPageIndex == 1)
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
                                onTap: () {
                                  /// TODO: add a jump dialog
                                },
                                readOnly: true,
                                textAlign: TextAlign.center,
                                controller: paginationTextController),
                          )),
                      Expanded(
                          flex: 1,
                          child: (currentPageIndex == lastPageIndex)
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
                  gridDelegate:
                      const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemCount: galleries!.length,
                  itemBuilder: (context, index) =>
                      GalleryCard(galleries![index])),
        ));
  }

  void getLatestUpdateGalleries(int pageIndex) async {
    final response =
        await http.get(Uri.parse(proxy('$hostUrl?page=$pageIndex')));
    final document = html_parser.parse(response.body);
    final newUploadsDiv =
        document.querySelectorAll('.container.index-container').lastOrNull;
    final paginationSection = document.querySelector('.pagination');
    if (newUploadsDiv != null) {
      final galleries = newUploadsDiv.querySelectorAll('.gallery');
      setState(() {
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
              .toList();
          return Gallery(id, title, coverImageUrl, tagIds);
        }).toList();
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
          title: const Text('网络错误'),
          autoCloseDuration: const Duration(seconds: 3));
    }
  }

  void getSearchGalleries(int pageIndex) async {
    final response = await http.get(Uri.parse(proxy(
        '$hostUrl/search/?q=${tagFilterStore.tags.where((tag) => tag.tagState == TagState.banned || tag.tagState == TagState.required).map((tag) => '${tag.tagState == TagState.banned ? '-' : ''}${{
              TagType.tag: 'tag',
              TagType.artist: 'artists',
              TagType.character: 'characters',
              TagType.parody: 'parodies',
              TagType.group: 'groups',
            }[tag.tagType]}%3A"${tag.name.replaceAll(' ', '+')}"').join('+')}${searching ? '+${searchController.text.replaceAll(' ', '+')}' : ''}&page=$pageIndex')));
    final document = html_parser.parse(response.body);
    final newUploadsDiv =
        document.querySelectorAll('.container.index-container').lastOrNull;
    final paginationSection = document.querySelector('.pagination');
    if (newUploadsDiv != null) {
      final galleries = newUploadsDiv.querySelectorAll('.gallery');
      setState(() {
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
              .toList();
          return Gallery(id, title, coverImageUrl, tagIds);
        }).toList();
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
          title: const Text('网络错误'),
          autoCloseDuration: const Duration(seconds: 3));
    }
  }
}
