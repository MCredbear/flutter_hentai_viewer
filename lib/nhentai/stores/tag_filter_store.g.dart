// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_filter_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TagFilterStore on TagFilterStoreBase, Store {
  late final _$tagsAtom =
      Atom(name: 'TagFilterStoreBase.tags', context: context);

  @override
  ObservableList<Tag> get tags {
    _$tagsAtom.reportRead();
    return super.tags;
  }

  @override
  set tags(ObservableList<Tag> value) {
    _$tagsAtom.reportWrite(value, super.tags, () {
      super.tags = value;
    });
  }

  late final _$bannedTagIdsAtom =
      Atom(name: 'TagFilterStoreBase.bannedTagIds', context: context);

  @override
  ObservableList<int> get bannedTagIds {
    _$bannedTagIdsAtom.reportRead();
    return super.bannedTagIds;
  }

  @override
  set bannedTagIds(ObservableList<int> value) {
    _$bannedTagIdsAtom.reportWrite(value, super.bannedTagIds, () {
      super.bannedTagIds = value;
    });
  }

  late final _$requiredTagIdsAtom =
      Atom(name: 'TagFilterStoreBase.requiredTagIds', context: context);

  @override
  ObservableList<int> get requiredTagIds {
    _$requiredTagIdsAtom.reportRead();
    return super.requiredTagIds;
  }

  @override
  set requiredTagIds(ObservableList<int> value) {
    _$requiredTagIdsAtom.reportWrite(value, super.requiredTagIds, () {
      super.requiredTagIds = value;
    });
  }

  late final _$pullTagsAsyncAction =
      AsyncAction('TagFilterStoreBase.pullTags', context: context);

  @override
  Future<void> pullTags() {
    return _$pullTagsAsyncAction.run(() => super.pullTags());
  }

  @override
  String toString() {
    return '''
tags: ${tags},
bannedTagIds: ${bannedTagIds},
requiredTagIds: ${requiredTagIds}
    ''';
  }
}
