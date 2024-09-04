import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/generated/l10n.dart';
import 'package:flutter_hentai_viewer/nhentai/stores/tag_filter_store.dart';
import 'package:flutter_hentai_viewer/nhentai/tag.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class TagFilterPage extends StatefulWidget {
  const TagFilterPage({super.key});

  @override
  State<TagFilterPage> createState() => _TagFilterPageState();
}

class _TagFilterPageState extends State<TagFilterPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 6, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        setState(() {
          switch (tabController.index) {
            case 0:
              enabledTagChips = tagChips
                  .where((tagChip) =>
                      tagChip.tag.tagState == TagState.banned ||
                      tagChip.tag.tagState == TagState.required)
                  .toList()
                ..sort(compareTagChip);
              break;
            case 1:
              tagTagChips = tagChips
                  .where((tagChip) => tagChip.tag.tagType == TagType.tag)
                  .toList()
                ..sort(compareTagChip);
              break;
            case 2:
              artistTagChips = tagChips
                  .where((tagChip) => tagChip.tag.tagType == TagType.artist)
                  .toList()
                ..sort(compareTagChip);
              break;
            case 3:
              characterTagChips = tagChips
                  .where((tagChip) => tagChip.tag.tagType == TagType.character)
                  .toList()
                ..sort(compareTagChip);
              break;
            case 4:
              parodyTagChips = tagChips
                  .where((tagChip) => tagChip.tag.tagType == TagType.parody)
                  .toList()
                ..sort(compareTagChip);
            case 5:
              parodyTagChips = tagChips
                  .where((tagChip) => tagChip.tag.tagType == TagType.parody)
                  .toList()
                ..sort(compareTagChip);
              groupTagChips = tagChips
                  .where((tagChip) => tagChip.tag.tagType == TagType.group)
                  .toList()
                ..sort(compareTagChip);
            default:
          }
        });
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  late final TabController tabController;

  final tagChips = tagFilterStore.tags.map((tag) => TagChip(tag));

  late var enabledTagChips = tagChips
      .where((tagChip) =>
          tagChip.tag.tagState == TagState.banned ||
          tagChip.tag.tagState == TagState.required)
      .toList()
    ..sort(compareTagChip);
  late var tagTagChips = tagChips
      .where((tagChip) => tagChip.tag.tagType == TagType.tag)
      .toList()
    ..sort(compareTagChip);
  late var artistTagChips = tagChips
      .where((tagChip) => tagChip.tag.tagType == TagType.artist)
      .toList()
    ..sort(compareTagChip);
  late var characterTagChips = tagChips
      .where((tagChip) => tagChip.tag.tagType == TagType.character)
      .toList()
    ..sort(compareTagChip);
  late var parodyTagChips = tagChips
      .where((tagChip) => tagChip.tag.tagType == TagType.parody)
      .toList()
    ..sort(compareTagChip);
  late var groupTagChips = tagChips
      .where((tagChip) => tagChip.tag.tagType == TagType.group)
      .toList()
    ..sort(compareTagChip);

  int compareTagChip(TagChip a, TagChip b) {
    int valueA = a.tag.tagState == TagState.banned
        ? 0x100
        : a.tag.tagState == TagState.required
            ? 0x010
            : 0x000;
    int valueB = b.tag.tagState == TagState.banned
        ? 0x100
        : b.tag.tagState == TagState.required
            ? 0x010
            : 0x000;
    a.tag.count! > b.tag.count! ? valueA |= 0x001 : valueB |= 0x001;
    return valueB - valueA;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: TextField(
                  decoration: const InputDecoration(label: Icon(Icons.search)),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        switch (tabController.index) {
                          case 0:
                            enabledTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagState == TagState.banned ||
                                    tagChip.tag.tagState == TagState.required)
                                .where((tagChip) =>
                                    tagChip.tag.name.contains(value))
                                .toList()
                              ..sort(compareTagChip);
                            break;
                          case 1:
                            tagTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.tag)
                                .where((tagChip) =>
                                    tagChip.tag.name.contains(value))
                                .toList()
                              ..sort(compareTagChip);
                            break;
                          case 2:
                            artistTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.artist)
                                .where((tagChip) =>
                                    tagChip.tag.name.contains(value))
                                .toList()
                              ..sort(compareTagChip);
                            break;
                          case 3:
                            characterTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.character)
                                .where((tagChip) =>
                                    tagChip.tag.name.contains(value))
                                .toList()
                              ..sort(compareTagChip);
                            break;
                          case 4:
                            parodyTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.parody)
                                .where((tagChip) =>
                                    tagChip.tag.name.contains(value))
                                .toList()
                              ..sort(compareTagChip);
                          case 5:
                            parodyTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.parody)
                                .where((tagChip) =>
                                    tagChip.tag.name.contains(value))
                                .toList()
                              ..sort(compareTagChip);
                            groupTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.group)
                                .where((tagChip) =>
                                    tagChip.tag.name.contains(value))
                                .toList()
                              ..sort(compareTagChip);
                          default:
                        }
                      });
                    } else {
                      setState(() {
                        switch (tabController.index) {
                          case 0:
                            enabledTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagState == TagState.banned ||
                                    tagChip.tag.tagState == TagState.required)
                                .toList()
                              ..sort(compareTagChip);
                            break;
                          case 1:
                            tagTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.tag)
                                .toList()
                              ..sort(compareTagChip);
                            break;
                          case 2:
                            artistTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.artist)
                                .toList()
                              ..sort(compareTagChip);
                            break;
                          case 3:
                            characterTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.character)
                                .toList()
                              ..sort(compareTagChip);
                            break;
                          case 4:
                            parodyTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.parody)
                                .toList()
                              ..sort(compareTagChip);
                          case 5:
                            parodyTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.parody)
                                .toList()
                              ..sort(compareTagChip);
                            groupTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.group)
                                .toList()
                              ..sort(compareTagChip);
                          default:
                        }
                      });
                    }
                  }),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
        bottom: TabBar(controller: tabController, isScrollable: true, tabs: [
          Text(L10n.of(context).enabledTag, textAlign: TextAlign.center),
          Text(L10n.of(context).tag, textAlign: TextAlign.center),
          Text(L10n.of(context).artist, textAlign: TextAlign.center),
          Text(L10n.of(context).character, textAlign: TextAlign.center),
          Text(L10n.of(context).parody, textAlign: TextAlign.center),
          Text(L10n.of(context).group, textAlign: TextAlign.center)
        ]),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          WaterfallFlow(
            gridDelegate:
                const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
            children: enabledTagChips,
          ),
          WaterfallFlow(
            gridDelegate:
                const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
            children: tagTagChips,
          ),
          WaterfallFlow(
            gridDelegate:
                const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
            children: artistTagChips,
          ),
          WaterfallFlow(
            gridDelegate:
                const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
            children: characterTagChips,
          ),
          WaterfallFlow(
            gridDelegate:
                const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
            children: parodyTagChips,
          ),
          WaterfallFlow(
            gridDelegate:
                const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
            children: groupTagChips,
          ),
        ],
      ),
    );
  }
}

class TagChip extends StatefulWidget {
  const TagChip(
    this.tag, {
    super.key,
  });

  final Tag tag;

  @override
  State<TagChip> createState() => _TagChipState();
}

class _TagChipState extends State<TagChip> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(2.5),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                backgroundColor: Theme.of(context).cardColor),
            onPressed: () {
              setState(() {
                widget.tag.tagState = switch (widget.tag.tagState) {
                  TagState.disabled => TagState.required,
                  TagState.required => TagState.banned,
                  TagState.banned => TagState.disabled,
                  null => TagState.disabled
                };
              });
              tagFilterStore.save();
            },
            child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 30,
                    child: switch (widget.tag.tagState) {
                      TagState.disabled => null,
                      TagState.banned => const Icon(Icons.close),
                      TagState.required => const Icon(Icons.check),
                      null => null
                    },
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(widget.tag.name,
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(width: 5),
                  Text('${widget.tag.count}')
                ],
              ),
            )));
  }
}
