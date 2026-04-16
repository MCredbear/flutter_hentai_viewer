import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/nhentai/api/api.dart';
import 'package:flutter_hentai_viewer/nhentai/tag.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
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
          oldTag.type != tag.type ||
          oldTag.count != tag.count) {
        isUpdated = true;
        oldTag.name = tag.name;
        oldTag.type = tag.type;
        oldTag.count = tag.count;
      }
    }
    if (isUpdated) {
      save();
    }
  }

  @action
  Future<void> pullTags() async {
    for (final type in TagType.values) {
      final tags = await searchTags('', type);
      await updateTags(tags);
      toastification.show(
          title: Text('Fetched type: ${type.name}, count: ${tags.length}'),
          autoCloseDuration: const Duration(seconds: 3));
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
      save();
      try {
        await pullTags();
      } catch (e) {
        toastification.show(
            title: Text('Error fetching tags: $e'),
            autoCloseDuration: const Duration(seconds: 3));
      }
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
