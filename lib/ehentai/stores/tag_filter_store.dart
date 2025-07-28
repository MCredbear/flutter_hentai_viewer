import 'dart:convert';
import 'dart:io';

import 'package:flutter_hentai_viewer/ehentai/tag.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';

part 'tag_filter_store.g.dart';

TagFilterStore tagFilterStore = TagFilterStore();

class TagFilterStore = TagFilterStoreBase with _$TagFilterStore;

abstract class TagFilterStoreBase with Store {
  @observable
  ObservableList<Tag> tags = ObservableList();

  @action
  Future<void> updateTags(List<Tag> tags) async {
    final beforeLength = this.tags.length;
    for (final tag in tags) {
      if (!this.tags.contains(tag)) {
        this.tags.add(tag);
      }
    }
    if (beforeLength != this.tags.length) {
      save();
    }
  }

  @observable
  ObservableList<Tag> bannedTags = ObservableList();

  @observable
  ObservableList<Tag> requiredTags = ObservableList();

  @action
  void setTagState(Tag tag, TagState? tagState) {
    tags.firstWhere((t) => t == tag).tagState = tagState;
    bannedTags = tags
        .where((tag) => tag.tagState == TagState.banned)
        .toList()
        .asObservable();
    requiredTags = tags
        .where((tag) => tag.tagState == TagState.required)
        .toList()
        .asObservable();
    save();
  }

  @action
  Future<void> read() async {
    final appDir = await getApplicationSupportDirectory();
    final file = File('${appDir.path}/ehentai_tags.json');
    if (!file.existsSync()) {
      // init
      save();
    } else {
      tags = ObservableList.of(
          (json.decode(file.readAsStringSync()) as List<dynamic>)
              .map((tag) => Tag.fromJson(tag as Map<String, dynamic>)));
    }
    bannedTags = tags
        .where((tag) => tag.tagState == TagState.banned)
        .toList()
        .asObservable();
    requiredTags = tags
        .where((tag) => tag.tagState == TagState.required)
        .toList()
        .asObservable();
  }

  Future<void> save() async {
    var appDir = await getApplicationSupportDirectory();
    var file = File('${appDir.path}/ehentai_tags.json');
    file.writeAsStringSync(json.encode(tags));
  }
}
