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

  late final _$bannedTagsAtom =
      Atom(name: 'TagFilterStoreBase.bannedTags', context: context);

  @override
  ObservableList<Tag> get bannedTags {
    _$bannedTagsAtom.reportRead();
    return super.bannedTags;
  }

  @override
  set bannedTags(ObservableList<Tag> value) {
    _$bannedTagsAtom.reportWrite(value, super.bannedTags, () {
      super.bannedTags = value;
    });
  }

  late final _$requiredTagsAtom =
      Atom(name: 'TagFilterStoreBase.requiredTags', context: context);

  @override
  ObservableList<Tag> get requiredTags {
    _$requiredTagsAtom.reportRead();
    return super.requiredTags;
  }

  @override
  set requiredTags(ObservableList<Tag> value) {
    _$requiredTagsAtom.reportWrite(value, super.requiredTags, () {
      super.requiredTags = value;
    });
  }

  late final _$updateTagsAsyncAction =
      AsyncAction('TagFilterStoreBase.updateTags', context: context);

  @override
  Future<void> updateTags(List<Tag> tags) {
    return _$updateTagsAsyncAction.run(() => super.updateTags(tags));
  }

  late final _$readAsyncAction =
      AsyncAction('TagFilterStoreBase.read', context: context);

  @override
  Future<void> read() {
    return _$readAsyncAction.run(() => super.read());
  }

  late final _$TagFilterStoreBaseActionController =
      ActionController(name: 'TagFilterStoreBase', context: context);

  @override
  void setTagState(Tag tag, TagState? tagState) {
    final _$actionInfo = _$TagFilterStoreBaseActionController.startAction(
        name: 'TagFilterStoreBase.setTagState');
    try {
      return super.setTagState(tag, tagState);
    } finally {
      _$TagFilterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tags: ${tags},
bannedTags: ${bannedTags},
requiredTags: ${requiredTags}
    ''';
  }
}
