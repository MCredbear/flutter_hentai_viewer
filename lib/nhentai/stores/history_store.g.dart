// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HistoryStore on HistoryStoreBase, Store {
  late final _$historyGalleriesAtom =
      Atom(name: 'HistoryStoreBase.historyGalleries', context: context);

  @override
  ObservableList<Gallery> get historyGalleries {
    _$historyGalleriesAtom.reportRead();
    return super.historyGalleries;
  }

  @override
  set historyGalleries(ObservableList<Gallery> value) {
    _$historyGalleriesAtom.reportWrite(value, super.historyGalleries, () {
      super.historyGalleries = value;
    });
  }

  late final _$HistoryStoreBaseActionController =
      ActionController(name: 'HistoryStoreBase', context: context);

  @override
  void add(Gallery gallery) {
    final _$actionInfo = _$HistoryStoreBaseActionController.startAction(
        name: 'HistoryStoreBase.add');
    try {
      return super.add(gallery);
    } finally {
      _$HistoryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void remove(Gallery gallery) {
    final _$actionInfo = _$HistoryStoreBaseActionController.startAction(
        name: 'HistoryStoreBase.remove');
    try {
      return super.remove(gallery);
    } finally {
      _$HistoryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
historyGalleries: ${historyGalleries}
    ''';
  }
}
