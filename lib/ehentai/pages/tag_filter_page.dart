import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/generated/l10n.dart';
import 'package:flutter_hentai_viewer/ehentai/stores/tag_filter_store.dart';
import 'package:flutter_hentai_viewer/ehentai/tag.dart';
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
    tabController = TabController(length: 10, vsync: this);
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
              languageTagChips = tagChips
                  .where((tagChip) => tagChip.tag.tagType == TagType.language)
                  .toList()
                ..sort(compareTagChip);
              break;
            case 2:
              parodyTagChips = tagChips
                  .where((tagChip) => tagChip.tag.tagType == TagType.parody)
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
              artistTagChips = tagChips
                  .where((tagChip) => tagChip.tag.tagType == TagType.artist)
                  .toList()
                ..sort(compareTagChip);
              break;
            case 5:
              groupTagChips = tagChips
                  .where((tagChip) => tagChip.tag.tagType == TagType.group)
                  .toList()
                ..sort(compareTagChip);
              break;
            case 6:
              femaleTagChips = tagChips
                  .where((tagChip) => tagChip.tag.tagType == TagType.female)
                  .toList()
                ..sort(compareTagChip);
              break;
            case 7:
              maleTagChips = tagChips
                  .where((tagChip) => tagChip.tag.tagType == TagType.male)
                  .toList()
                ..sort(compareTagChip);
              break;
            case 8:
              mixedTagChips = tagChips
                  .where((tagChip) => tagChip.tag.tagType == TagType.mixed)
                  .toList()
                ..sort(compareTagChip);
              break;
            case 9:
              otherTagChips = tagChips
                  .where((tagChip) => tagChip.tag.tagType == TagType.other)
                  .toList()
                ..sort(compareTagChip);
              break;
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
  late var languageTagChips = tagChips
      .where((tagChip) => tagChip.tag.tagType == TagType.language)
      .toList()
    ..sort(compareTagChip);
  late var parodyTagChips = tagChips
      .where((tagChip) => tagChip.tag.tagType == TagType.parody)
      .toList()
    ..sort(compareTagChip);
  late var characterTagChips = tagChips
      .where((tagChip) => tagChip.tag.tagType == TagType.character)
      .toList()
    ..sort(compareTagChip);
  late var artistTagChips = tagChips
      .where((tagChip) => tagChip.tag.tagType == TagType.artist)
      .toList()
    ..sort(compareTagChip);
  late var groupTagChips = tagChips
      .where((tagChip) => tagChip.tag.tagType == TagType.group)
      .toList()
    ..sort(compareTagChip);
  late var femaleTagChips = tagChips
      .where((tagChip) => tagChip.tag.tagType == TagType.group)
      .toList()
    ..sort(compareTagChip);
  late var maleTagChips = tagChips
      .where((tagChip) => tagChip.tag.tagType == TagType.group)
      .toList()
    ..sort(compareTagChip);
  late var mixedTagChips = tagChips
      .where((tagChip) => tagChip.tag.tagType == TagType.group)
      .toList()
    ..sort(compareTagChip);
  late var otherTagChips = tagChips
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
    if (valueA != valueB) {
      return valueB - valueA;
    }
    return a.tag.name.compareTo(b.tag.name);
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
                            languageTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.language)
                                .where((tagChip) =>
                                    tagChip.tag.name.contains(value))
                                .toList()
                              ..sort(compareTagChip);
                            break;
                          case 2:
                            parodyTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.parody)
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
                            artistTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.artist)
                                .where((tagChip) =>
                                    tagChip.tag.name.contains(value))
                                .toList()
                              ..sort(compareTagChip);
                          case 5:
                            groupTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.group)
                                .where((tagChip) =>
                                    tagChip.tag.name.contains(value))
                                .toList()
                              ..sort(compareTagChip);
                          case 6:
                            femaleTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.female)
                                .where((tagChip) =>
                                    tagChip.tag.name.contains(value))
                                .toList()
                              ..sort(compareTagChip);
                            break;
                          case 7:
                            maleTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.male)
                                .where((tagChip) =>
                                    tagChip.tag.name.contains(value))
                                .toList()
                              ..sort(compareTagChip);
                            break;
                          case 8:
                            mixedTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.mixed)
                                .where((tagChip) =>
                                    tagChip.tag.name.contains(value))
                                .toList()
                              ..sort(compareTagChip);
                            break;
                          case 9:
                            otherTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.other)
                                .where((tagChip) =>
                                    tagChip.tag.name.contains(value))
                                .toList()
                              ..sort(compareTagChip);
                            break;
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
                            languageTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.language)
                                .toList()
                              ..sort(compareTagChip);
                            break;
                          case 2:
                            parodyTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.parody)
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
                            artistTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.artist)
                                .toList()
                              ..sort(compareTagChip);
                            break;
                          case 5:
                            groupTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.group)
                                .toList()
                              ..sort(compareTagChip);
                            break;
                          case 6:
                            femaleTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.female)
                                .toList()
                              ..sort(compareTagChip);
                            break;
                          case 7:
                            maleTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.female)
                                .toList()
                              ..sort(compareTagChip);
                            break;
                          case 8:
                            mixedTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.mixed)
                                .toList()
                              ..sort(compareTagChip);
                            break;
                          case 9:
                            otherTagChips = tagChips
                                .where((tagChip) =>
                                    tagChip.tag.tagType == TagType.other)
                                .toList()
                              ..sort(compareTagChip);
                            break;
                          default:
                        }
                      });
                    }
                  }),
            ),
          ],
        ),
        bottom: TabBar(controller: tabController, isScrollable: true, tabs: [
          Text(L10n.of(context).enabledTag, textAlign: TextAlign.center),
          Text(L10n.of(context).language, textAlign: TextAlign.center),
          Text(L10n.of(context).parody, textAlign: TextAlign.center),
          Text(L10n.of(context).character, textAlign: TextAlign.center),
          Text(L10n.of(context).artist, textAlign: TextAlign.center),
          Text(L10n.of(context).group, textAlign: TextAlign.center),
          Text(L10n.of(context).female, textAlign: TextAlign.center),
          Text(L10n.of(context).male, textAlign: TextAlign.center),
          Text(L10n.of(context).mixed, textAlign: TextAlign.center),
          Text(L10n.of(context).other, textAlign: TextAlign.center),
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
            children: languageTagChips,
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
            children: characterTagChips,
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
            children: groupTagChips,
          ),
          WaterfallFlow(
            gridDelegate:
                const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
            children: femaleTagChips,
          ),
          WaterfallFlow(
            gridDelegate:
                const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
            children: maleTagChips,
          ),
          WaterfallFlow(
            gridDelegate:
                const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
            children: mixedTagChips,
          ),
          WaterfallFlow(
            gridDelegate:
                const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
            children: otherTagChips,
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
                tagFilterStore.setTagState(
                    widget.tag,
                    switch (widget.tag.tagState) {
                      TagState.required => TagState.banned,
                      TagState.banned => null,
                      null => TagState.required
                    });
              });
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
                      TagState.banned => const Icon(Icons.close),
                      TagState.required => const Icon(Icons.check),
                      null => null
                    },
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      widget.tag.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                ],
              ),
            )));
  }
}
