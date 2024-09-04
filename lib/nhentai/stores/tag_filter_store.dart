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
          for (final tagA in tagsSpan) {
            final id = int.parse(tagA.className.split(' ')[1].split('-')[1]);
            final nameSpan = tagA.querySelector('.name');
            final name = nameSpan!.text;
            final countSpan = tagA.querySelector('.count');
            final count = countSpan!.text;

            final oldTag = tags.firstWhere((tag) => tag.id == id, orElse: () {
              final newTag = Tag(id, name, entry.key);
              tags.add(newTag);
              return newTag;
            });

            oldTag.name = name;
            oldTag.tagType = entry.key;
            oldTag.count = count.endsWith('K')
                ? int.parse(count.substring(0, count.length - 1)) * 1000
                : int.parse(count);
          }
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

    save();
  }

  @observable
  ObservableList<int> bannedTagIds = ObservableList();

  @observable
  ObservableList<int> requiredTagIds = ObservableList();

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
  }

  Future<void> save() async {
    var appDir = await getApplicationSupportDirectory();
    var file = File('${appDir.path}/nhentai_tags.json');
    file.writeAsStringSync(json.encode(tags));
  }
}
