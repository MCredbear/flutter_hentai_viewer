import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hentai_viewer/nhentai/tag.dart';
import 'package:flutter_hentai_viewer/nhentai/utils.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:toastification/toastification.dart';

part 'tag_filter_store.g.dart';

TagFilterStore tagFilterStore = TagFilterStore();

class TagFilterStore = TagFilterStoreBase with _$TagFilterStore;

abstract class TagFilterStoreBase with Store {
  @observable
  ObservableList<Tag> tags = ObservableList();

  @action
  Future<void> updateTags(List<Tag> tags) async {
    bool isUpdated = false;
    for (final tag in tags) {
      final oldTag = this.tags.firstWhere((t) => t.id == tag.id, orElse: () {
        isUpdated = true;
        this.tags.add(tag);
        return tag;
      });
      if (oldTag.name != tag.name ||
          oldTag.tagType != tag.tagType ||
          oldTag.count != tag.count) {
        isUpdated = true;
        oldTag.name = tag.name;
        oldTag.tagType = tag.tagType;
        oldTag.count = tag.count;
      }
    }
    if (isUpdated) {
      save();
    }
  }

  @action
  Future<void> pullTags() async {
    final tagTypeToName = {
      TagType.tag: 'tags',
      TagType.artist: 'artists',
      TagType.character: 'characters',
      TagType.parody: 'parodies',
      TagType.group: 'groups',
    };
    for (final entry in tagTypeToName.entries) {
      int pageIndex = 1;
      while (true) {
        final response = await http.get(Uri.parse(
            proxy('$hostUrl/${entry.value}/popular?page=$pageIndex')));
        final document = html_parser.parse(response.body);
        final tagsDiv = document.querySelector('#tag-container.container');
        if (tagsDiv != null) {
          final tagsSpan = tagsDiv.querySelectorAll('.tag');
          final tags = tagsSpan.map((tagA) {
            final id = int.parse(tagA.className.split(' ')[1].split('-')[1]);
            final nameSpan = tagA.querySelector('.name');
            final name = nameSpan!.text;
            final countSpan = tagA.querySelector('.count');
            final countText = countSpan!.text;
            final count = countText.endsWith('K')
                ? int.parse(countText.substring(0, countText.length - 1)) * 1000
                : int.parse(countText);

            return Tag(id, name, entry.key, count: count);
          }).toList();
          await updateTags(tags);
        } else {
          break;
        }

        toastification.show(
            title: Text('Fetched type: ${entry.key}, page: $pageIndex'),
            autoCloseDuration: const Duration(seconds: 3));
        final nextPageLink = document.querySelector('.next');
        if (nextPageLink == null) break;
        pageIndex += 1;
      }
    }
  }

  @observable
  ObservableList<int> bannedTagIds = ObservableList();

  @observable
  ObservableList<int> requiredTagIds = ObservableList();

  @action
  void setTagState(int tagId, TagState? tagState) {
    final tag = tags.firstWhere((tag) => tag.id == tagId);
    tag.tagState = tagState;
    bannedTagIds = tags
        .where((tag) => tag.tagState == TagState.banned)
        .map((tag) => tag.id)
        .toList()
        .cast<int>()
        .asObservable();
    requiredTagIds = tags
        .where((tag) => tag.tagState == TagState.required)
        .map((tag) => tag.id)
        .toList()
        .cast<int>()
        .asObservable();
    save();
  }

  @action
  Future<void> read() async {
    final appDir = await getApplicationSupportDirectory();
    final file = File('${appDir.path}/nhentai_tags.json');
    if (!file.existsSync()) {
      // init
      tags = ObservableList.of(
          (json.decode(await rootBundle.loadString('assets/nhentai_tags.json'))
                  as List<dynamic>)
              .map((tag) => Tag.fromJson(tag as Map<String, dynamic>)));
      save();
    } else {
      tags = ObservableList.of(
          (json.decode(file.readAsStringSync()) as List<dynamic>)
              .map((tag) => Tag.fromJson(tag as Map<String, dynamic>)));
    }
    bannedTagIds = tags
        .where((tag) => tag.tagState == TagState.banned)
        .map((tag) => tag.id)
        .toList()
        .cast<int>()
        .asObservable();
    requiredTagIds = tags
        .where((tag) => tag.tagState == TagState.required)
        .map((tag) => tag.id)
        .toList()
        .cast<int>()
        .asObservable();
  }

  Future<void> save() async {
    var appDir = await getApplicationSupportDirectory();
    var file = File('${appDir.path}/nhentai_tags.json');
    file.writeAsStringSync(json.encode(tags));
  }
}
